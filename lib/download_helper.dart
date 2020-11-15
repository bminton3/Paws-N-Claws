import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_vet_tv/base_video_player.dart';
import 'package:my_vet_tv/shared_preferences_helper.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'util.dart';
import 'dart:developer' as developer;

const debug = true;
const ClassName = 'DownloadHelper';
const api = 'https://firebasestorage.googleapis.com/v0/b/pawsnclaws-minton.appspot.com/o';
const _firebaseMetadata = 'firebaseMetadata';

class DownloadHelper {
  final FirebaseStorage storage;

  DownloadHelper({this.storage});

  // ???
  DownloadHelper.fromJson(Map<String, dynamic> json) : storage = json['storage'];

  Map<String, dynamic> toJson() => {'storage': storage};

//  _addStringListToSharedPrefs(String key, List<List<String>> videos) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setStringList(key, videos);
//  }
//
//  _addVideoReferencesToSharedPrefs(String currentVideoSection) {
//    _addStringListToSharedPrefs(currentVideoSection, Util().catnutritionalinfo
//  }

  /// From https://medium.com/@danaya/download-assets-dynamically-in-flutter-16c3472a65e5
  String _dir;

//  Future<String> loadFirebaseMetadataAsset() async {
//    return await rootBundle.loadString('assets/firebaseMetadata');
//  }

  Future<void> downloadVideosFromFirebase() async {
    if (_dir == null) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }
    // download metadata file from firebase
    List<String> metaDataLines = await downloadFirebaseMetadataAndReadLines();

    for (int i = 0; i < metaDataLines.length; i++) {
      List<String> videoParts = metaDataLines[i].split(",");
      // Should be split into three parts:
      // 1. gs://pawsnclaws-minton.appspot.com/dog/caretips/Allergicreaction.mp4
      // 2. gs://pawsnclaws-minton.appspot.com/dog/caretips/thumbnails/dogallergicreaction.jpg
      // 3. Allergic Reaction
      // 1 is the video, 2 is the thumbnail, 3 is the title of the video to display
      if (videoParts.length > 1) {
        for (int i = 0; i < videoParts.length; i++) {
          print(videoParts[i]);
          List<String> fileParts = videoParts[i].split("/");
          if (fileParts.length > 1) {
            String filename = fileParts[fileParts.length - 1];
            // looks at the actual local file location to see if it exists. Doesn't check the sharedprefs
            // filename here is just the end of the firebase url. eg, Allergicreaction.mp4
            if (!await fileExists(filename)) {
              await downloadFirebaseFileToLocal(videoParts[i], filename);
            }
          }
        }
      }
    }
    // was using just for cleanup for some reason???
//    Util().clearArrays();
    await createVideoObjectsFromMetadata(metaDataLines);

    var metadatafileexists = (await fileExists('firebaseMetadata')).toString();
    print("metadata file exists: " + metadatafileexists);
  }

  /**
   * Simply parses the metadata file and builds an array with references to the video locations
   * Generates the local reference strings for all the files to be downloaded from Firebase
   */
  Future<void> createVideoObjectsFromMetadata(List<String> metaDataLines) async {
    var currentVideoSection = "test";

    // Parts of a PawsVideo
    var currentVideoTitle;
    var currentVideoFilename;
    var currentVideoThumbnail;
    // Parsing the metadata file line by line.
    for (int i = 0; i < metaDataLines.length; i++) {
      List<String> videoParts = metaDataLines[i].split(",");
      if (videoParts.length > 1) {
        for (int i = 0; i < videoParts.length; i++) {
          List<String> fileParts = videoParts[i].split("/");
          //print(fileParts[fileParts.length - 1]);
          // assumption that one word lines will be separators
          if (fileParts.length > 1) {
            // First part is the video
            if (i == 0) {
              // ex: fileName = Arthritis.mp4
              var fileName = fileParts[fileParts.length - 1];
              currentVideoFilename = fileName;
              // Second part is the thumbnail
            } else if (i == 1) {
              var fileName = fileParts[fileParts.length - 1];
              currentVideoThumbnail = fileName;
            }
            // Third part is the title
          } else {
            currentVideoTitle = fileParts[0];
          }
        }
        // Next section
      } else {
        currentVideoSection = metaDataLines[i];
      }
      //** Now that we have the path to the video, thumbnail, and a title, add it to our array we'll
      //** reference.
      await createPawsVideo(
          currentVideoTitle, currentVideoFilename, currentVideoThumbnail, currentVideoSection);

      currentVideoFilename = null;
      currentVideoThumbnail = null;
      currentVideoTitle = null;
    }
  }

  /**
   * Creates PawsVideo objects out of the parsed Metadata file string.
   */
  Future<void> createPawsVideo(String currentVideoTitle, String currentVideoFile,
      String currentVideoThumbnail, String currentVideoSection) async {
    SharedPref sharedPref = SharedPref();
    Util util;
    try {
      var prefUtil = await sharedPref.read('util');
      if (prefUtil == null) {
        developer.log('Util is still null in shared preferences!');
        util = Util();
      } else {
        developer.log('Pulled Util out of shared prefs. Converting it from json.');
        util = Util.fromJson(prefUtil);
      }

      // TODO this needs to be more expandable
      if (currentVideoFile != null &&
          currentVideoThumbnail != null &&
          currentVideoTitle != null &&
          io.File(_dir + '/' + currentVideoFile).existsSync()) {
        try {
          developer.log('adding video ' + currentVideoFile + ' to ' + currentVideoSection,
              name: ClassName + '.buildVideoArrays()');
          switch (currentVideoSection) {
            case 'dogcaretips':
              util.dogcaretips[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              // PawsVideo(this.thumbnailName, this.name, this.thumbnailPath);
              break;
            case 'funnydogvideos':
              util.funnydogvideos[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'doggeneralhealth':
              util.doggeneralhealth[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'dogtraining':
              util.trainingdogvideos[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'dogtricks':
              util.trickdogvideos[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'catcaretips':
              util.catcaretips[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'catgeneralhealth':
              util.generalhealthcatvideos[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'cathelpfulinfo':
              util.cathelpfulinfo[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            case 'catnutritionalinfo':
              util.catnutritionalinfo[currentVideoFile] =
                  PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail);
              break;
            default:
              developer.log('Ended up in the default section of the switch statement',
                  name: ClassName + 'buildVideoArrays()');
              break;
          }
          sharedPref.save('util', util);
        } catch (Exception) {
          developer.log("There was an error creating the video objects\n" + Exception);
        }
      }
    } catch (Exception) {
      developer.log("There was an error just loading the shit out of shared prefs\n" + Exception);
      developer.log(Exception.toString());
    }
  }

  Future<bool> fileExists(String file) async {
    var f = io.File('$_dir/$file');
    bool fileExists = await f.exists();
    developer.log('$_dir/$file' + " exists: " + fileExists.toString());
    return f.exists();
  }

  /**
   * Example metadata line:
   * gs://pawsnclaws-minton.appspot.com/dog/caretips/Allergicreaction.mp4,gs://pawsnclaws-minton.appspot.com/dog/caretips/thumbnails/dogallergicreaction.jpg,Allergic Reaction
   */
  Future<List<String>> downloadFirebaseMetadataAndReadLines() async {
    //String fbMetadata = await loadFirebaseMetadataAsset();
    developer.log('downloading metadata file in ',
        name: ClassName + '.downloadFirebaseMetadataAndReadLines()');
    try {
      StorageReference ref =
          await storage.getReferenceFromUrl("gs://pawsnclaws-minton.appspot.com/firebaseMetadata");
      var url = await ref.getDownloadURL() as String;
      final http.Response downloadData = await http.get(url);
      final String fileContents = downloadData.body;
      var file = io.File('$_dir/$_firebaseMetadata');
      file.writeAsBytes(downloadData.bodyBytes);
      List<String> metaDataLines = fileContents.split("\n");
      return metaDataLines;
    } catch (Exception) {
      // TODO implement reading from local
      var file = io.File('$_dir/$_firebaseMetadata');
    }
  }

  Future<bool> downloadFirebaseFileToLocal(String fileUrl, String localFilename) async {
    StorageReference ref = await storage.getReferenceFromUrl(fileUrl);
    var url = await ref.getDownloadURL() as String;
    final http.Response downloadData = await http.get(url);
    var file = io.File('$_dir/$localFilename');
    file.writeAsBytes(downloadData.bodyBytes);
    developer.log('Successfully downloaded and saved file: ' + localFilename);
    return true;
  }

//  Future<File> _downloadFile(String url, String filename, String dir) async {
//    var req = await http.Client().get(Uri.parse(url));
//    var file = File('$dir/$filename');
//    return file.writeAsBytes(req.bodyBytes);
//  }
}
