import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_vet_tv/base_video_player.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'util.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:developer' as developer;

const debug = true;
const ClassName = 'DownloadHelper';
const api = 'https://firebasestorage.googleapis.com/v0/b/pawsnclaws-minton.appspot.com/o';
const _firebaseMetadata = 'firebaseMetadata';

class DownloadHelper {
  final FirebaseStorage storage;
  DownloadHelper({this.storage});

  bool downloading = false;
  var progressString;

  /// From https://medium.com/@danaya/download-assets-dynamically-in-flutter-16c3472a65e5
  String _dir;
  List<String> _images;

  Future<String> loadFirebaseMetadataAsset() async {
    return await rootBundle.loadString('assets/firebaseMetadata');
  }

  Future<void> downloadVideosFromFirebase() async {
    if (_dir == null) {
      _dir = (await getApplicationDocumentsDirectory()).path;
      dir = _dir;
      Util().setURL(dir);
    }
    // download metadata file from firebase
    List<String> metaDataLines = await downloadFirebaseMetadataAndReadLines();

    // TODO create video objects from metadata
    createVideoObjectsFromMetadata(metaDataLines);

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
          //print(fileParts[fileParts.length - 1]);
          // assumption that one word lines will be separators
          if (fileParts.length > 1) {
            if (!await fileExists(fileParts[fileParts.length - 1])) {
              await downloadFirebaseFileToLocal(videoParts[i], fileParts[fileParts.length - 1]);
            }
          }
        }
      }
    }

    var metadatafileexists = (await fileExists('firebaseMetadata')).toString();
    print("metadata file exists: " + metadatafileexists);
  }

  void createVideoObjectsFromMetadata(List<String> metaDataLines) {
    var currentVideoSection = "test";

    // Parts of a PawsVideo
    var currentVideoTitle;
    var currentVideoFile;
    var currentVideoThumbnail;

    for (int i = 0; i < metaDataLines.length; i++) {
      List<String> videoParts = metaDataLines[i].split(",");
      if (videoParts.length > 1) {
        for (int i = 0; i < videoParts.length; i++) {
          List<String> fileParts = videoParts[i].split("/");
          //print(fileParts[fileParts.length - 1]);
          // assumption that one word lines will be separators
          if (fileParts.length > 1) {
            // First one is the video
            if (i == 0) {
              var fileName = fileParts[fileParts.length - 1];
              currentVideoFile = '$_dir/' + '$fileName';
            } else if (i == 1) {
              var fileName = fileParts[fileParts.length - 1];
              currentVideoThumbnail = '$_dir/' + '$fileName';
            }
          } else {
            currentVideoTitle = fileParts[0];
          }
        }
      } else {
        currentVideoSection = metaDataLines[i];
      }
      //**
      buildVideoArrays(
          currentVideoTitle, currentVideoFile, currentVideoThumbnail, currentVideoSection);

      currentVideoFile = null;
      currentVideoThumbnail = null;
      currentVideoTitle = null;
    }
  }

  void buildVideoArrays(String currentVideoTitle, String currentVideoFile,
      String currentVideoThumbnail, String currentVideoSection) {
    // TODO this needs to be more expandable
    if (currentVideoFile != null && currentVideoThumbnail != null && currentVideoTitle != null) {
      switch (currentVideoSection) {
        case 'dogcaretips':
          developer.log('adding video' + currentVideoTitle + ' to ' + currentVideoSection,
              name: ClassName + 'buildVideoArrays()');
          Util()
              .dogcaretips
              .add(PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail));
          break;
        case 'funnydogvideos':
          developer.log('adding video' + currentVideoTitle + ' to ' + currentVideoSection,
              name: ClassName + 'buildVideoArrays()');
          Util()
              .funnydogvideos
              .add(PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail));
          break;
        case 'doggeneralhealth':
          developer.log('adding video' + currentVideoTitle + ' to ' + currentVideoSection,
              name: ClassName + 'buildVideoArrays()');
          Util()
              .generalhealthdogvideos
              .add(PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail));
          break;
        case 'dogtraining':
          developer.log('adding video' + currentVideoTitle + ' to ' + currentVideoSection,
              name: ClassName + 'buildVideoArrays()');
          Util()
              .trainingdogvideos
              .add(PawsVideo(currentVideoTitle, currentVideoFile, currentVideoThumbnail));
          break;
        default:
          developer.log('Ended up in the default section of the switch statement',
              name: ClassName + 'buildVideoArrays()');
          break;
      }
    }
  }

  Future<bool> fileExists(String file) async {
    var f = File('$_dir/$file');
    bool fileExists = await f.exists();
    print(file + " exists: " + fileExists.toString());
    return f.exists();
  }

  /**
   * Example metadata line:
   * gs://pawsnclaws-minton.appspot.com/dog/caretips/Allergicreaction.mp4,gs://pawsnclaws-minton.appspot.com/dog/caretips/thumbnails/dogallergicreaction.jpg,Allergic Reaction
   */
  Future<List<String>> downloadFirebaseMetadataAndReadLines() async {
    //String fbMetadata = await loadFirebaseMetadataAsset();
    try {
      StorageReference ref =
          await storage.getReferenceFromUrl("gs://pawsnclaws-minton.appspot.com/firebaseMetadata");
      var url = await ref.getDownloadURL() as String;
      final http.Response downloadData = await http.get(url);
      final String fileContents = downloadData.body;
      var file = File('$_dir/$_firebaseMetadata');
      file.writeAsBytes(downloadData.bodyBytes);
      List<String> metaDataLines = fileContents.split("\n");
      return metaDataLines;
    } catch (Exception) {
      // TODO implement reading from local
      var file = File('$_dir/$_firebaseMetadata');
    }
  }

  Future<bool> downloadFirebaseFileToLocal(String fileUrl, String localFilename) async {
    StorageReference ref = await storage.getReferenceFromUrl(fileUrl);
    var url = await ref.getDownloadURL() as String;
    final http.Response downloadData = await http.get(url);
    var file = File('$_dir/$localFilename');
    file.writeAsBytes(downloadData.bodyBytes);
    return true;
  }

//  Future<File> _downloadFile(String url, String filename, String dir) async {
//    var req = await http.Client().get(Uri.parse(url));
//    var file = File('$dir/$filename');
//    return file.writeAsBytes(req.bodyBytes);
//  }
}
