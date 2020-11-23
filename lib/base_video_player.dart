import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vet_tv/shared_preferences_helper.dart';
import 'package:my_vet_tv/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;

import 'play_pause_button.dart';

enum videotypes {
  Tricks,
  Training,
  GeneralHealth,
  Funny,
  CareTips,
  Nutrition,
  Behavior,
  Hygiene,
  HelpfulInfo,
  Reptiles,
  Rabbits,
  Birds,
  Rodents,
}

class VideoPlayerStatefulWidget extends StatefulWidget {
  @override
  createState() => new VideoPlayerStatefulWidgetState();
}

// TODO inconsistent directory structure in Dogvideo objects
// TODO implement automatic Dogvideo object creation from asset folder.
// TODO maybe create a factory pattern to create Dogvideos from the internet vs folders?
// TODO implement for cat videos, any type of videos, really
class VideoPlayerStatefulWidgetState extends State<VideoPlayerStatefulWidget> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  ScrollController _scrollController;
  SharedPref sharedPref;
  Future<dynamic> utilFuture;
  Util util = Util();
  String _dir;

  // currently selected video list
  videotypes selectedVideoType = videotypes.Funny;

  // video list
  String directory;
  List file = new List();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  void initState() {
    super.initState();
    sharedPref = SharedPref();
    utilFuture = sharedPref.read('util');
    var localpath = _localPath;
    //loadSharedPrefs();
    // which one of these mfers will work?
    loadSharedPrefs().then((result) {
      setState(() {
        util = result;
      });
    });
  }

  Future<Util> loadSharedPrefs() async {
    Util user;
    try {
      if (_dir == null) {
        _dir = (await getApplicationDocumentsDirectory()).path;
      }
      //type 'List<dynamic>' is not a subtype of type 'List<PawsVideo>'
      utilFuture = sharedPref.read('util');
      developer.log("utilFuture: " + utilFuture.toString());
      user = Util.fromJson(await sharedPref.read('util'));
      util = user;
      developer.log("util: " + util.toString());
      setState(() {
        util = user;
      });
    } catch (Exception) {
      developer.log("There was an error creating the video objects\n" + Exception);
      developer.log(Exception.toString());
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Container(
                decoration: BoxDecoration(color: AppBarColor),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 110,
                      width: 360,
                      child: Image.asset('assets/tailwag.png', fit: BoxFit.scaleDown),
                    ))),
            Expanded(
                child: Stack(children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                // background color
                color: Color(0xEF80D2F5),
                child: Column(children: [
                  //          Padding(padding: EdgeInsets.all(15.0)),

                  // back arrow
                  //          Row(children: [
                  //            GestureDetector(
                  //              child:
                  //              Container(
                  //                  padding: new EdgeInsets.only(left:2.0, top:20.0),
                  //                  child: SizedBox(
                  //                    height: 50,
                  //                    child: Image(
                  //                      image: AssetImage('assets/back-arrow.png'),
                  //                      fit: BoxFit.contain,
                  //                    ),
                  //                  )),
                  //              onTap:() => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName))
                  //            )
                  //          ]),

                  // side buttons
                  Row(
                    children: [
                      createSideButtons(),
                      // padding between side buttons and video
                      Padding(padding: EdgeInsets.all(25.0)),

                      // video
                      Expanded(
                        child: Stack(children: [
                          Container(
//                      padding: new EdgeInsets.all(32),
                            decoration: videoBorder(),
                            child: SizedBox(
                              width: 680,
                              height: 400,
                              child: Stack(children: [
                                VideoPlayPause(_videoPlayerController1),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(35.0)),
                  // bottom horizontal scroller with videos to choose from
                  Row(children: [
                    //Padding(padding: EdgeInsets.only(right: 30.0)),

                    // left arrow
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 90.0,
                          height: 90.0,
                          // doesn't have size
                          child: GestureDetector(
                            child: Container(
                              child: Image(
                                image: AssetImage('assets/brownarrowleft.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            // TODO there's gotta be a better way to do this
                            onTap: () => _moveLeft(),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(7.0)),
                    // horizontal video scroller
                    Expanded(
                      flex: 5,
                      child: Container(
//                        decoration: videoBorder(),
                          width: 1000.0,
                          height: 160.0,
                          // TODO put this whole fucking thing in a futurebuilder
                          child: FutureBuilder<dynamic>(
                            future: utilFuture,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (!snapshot.hasData) {
                                // while data is loading:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                // data loaded
                                var data = snapshot.data;
                                util = Util.fromJson(data);
                                return createCustomDynamicHorizontalImageScroller();
                              }
                            },
                          )
//                        child: createCustomDynamicHorizontalImageScroller(),
                          ),
                    ),
                    Padding(padding: EdgeInsets.all(7.0)),

                    // right arrow
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 90.0,
                          height: 90.0,
                          // doesn't have size
                          child: GestureDetector(
                            child: Container(
                              child: Image(
                                image: AssetImage('assets/brownarrowright.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            // TODO there's gotta be a better way to do this
                            onTap: () => _moveRight(),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
//              new FrostedGlassScreensaver(120),
            ]))
          ]),
          Positioned(
            right: 30.0,
            top: -40.0,
            child: Container(
              child: Image(
                image: AssetImage('assets/dogframe.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// To be overridden by child classes
  Widget createSideButtons() {}

  void _moveRight() {
    _scrollController.animateTo(_scrollController.offset + 200,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  void _moveLeft() {
    _scrollController.animateTo(_scrollController.offset - 200,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  /**
   * To be overidden by subclasses
   */
  Widget createCustomDynamicHorizontalImageScroller() {}

  /**
   * Actually loads the video files into the selectable horizontal scroller on the bottom of the screen
   * TODO load videos from both assets and downloaded locations
   */
  Container createDynamicHorizontalImageScroller(Map<String, dynamic> pawsvideos) {
    return Container(
        decoration: BoxDecoration(color: Color(0xEF80D2F5)),
        child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: pawsvideos.length,
            itemBuilder: (BuildContext ctxt, int index) {
              String key = pawsvideos.keys.elementAt(index);
              return Column(children: [
                // thumbnails
                Container(
                  key: Key("$index"),
                  width: 220.0,
                  height: 120.0,
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Image.file(
                            _getLocalFile(_dir + '/' + pawsvideos[key]['thumbnailPath'])),
                      ),
                      onTap: () {
                        // from https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
                        if (this.mounted) {
                          setState(() {
                            debugDumpApp();
                            print('Playing video number $index');
                            print('playing ' + pawsvideos[key]['name'] + 'video');
                            changeVideoFile(_dir + '/' + pawsvideos[key]['name']);
                          });
                        }
                      }),
                ),
                Text(pawsvideos[key]['thumbnailName'], // Maybe use a key/value pair instead?
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ]);
            })
//    child: ListView.builder(
//          itemCount: file.length,
//          itemBuilder: (BuildContext context, int index) {
//            return Text(file[index].toString());
//          }),
        );
  }

  Container createDynamicHorizontalImageScrollerForVideoAssets(List<PawsVideo> pawsvideos) {
    return Container(
        decoration: BoxDecoration(color: Color(0xEF80D2F5)),
        child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: pawsvideos.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Column(children: [
                Container(
                  width: 220.0,
                  height: 120.0,
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Image(
                          image: AssetImage(pawsvideos[index].thumbnailPath),
                          fit: BoxFit.fill,
                          width: 220,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          changeVideoAsset(pawsvideos[index].name);
                        });
                      }),
                ),
                Text(pawsvideos[index].thumbnailName, // Maybe use a key/value pair instead?
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ]);
            })
//    child: ListView.builder(
//          itemCount: file.length,
//          itemBuilder: (BuildContext context, int index) {
//            return Text(file[index].toString());
//          }),
        );
  }

  Widget createSideButton(String text) {
    return Stack(
      children: [
        SizedBox(
          width: 280,
          height: 75,
          child: GestureDetector(
              child: Container(
                child: Stack(children: [
                  Container(
                    child: Image(
                      image: AssetImage('assets/sidebutton.png'),
                      fit: BoxFit.contain,
                      width: 280,
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                  Center(
                    child: Container(
                      child: Text(text,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      alignment: Alignment(0.0, 0.5),
                    ),
                  ),
                ]),
              ),
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    switch (text) {
                      case 'Tricks':
                        {
                          selectedVideoType = videotypes.Tricks;
                        }
                        break;
                      case 'Training':
                        {
                          selectedVideoType = videotypes.Training;
                        }
                        break;
                      case 'General Health':
                        {
                          selectedVideoType = videotypes.GeneralHealth;
                        }
                        break;
                      case 'Funny Dogs':
                        {
                          selectedVideoType = videotypes.Funny;
                        }
                        break;
                      case 'Local Info':
                        {
                          selectedVideoType = videotypes.CareTips;
                        }
                        break;
                      case 'Funny Cats':
                        {
                          selectedVideoType = videotypes.Funny;
                        }
                        break;
                      case 'Nutrition':
                        {
                          selectedVideoType = videotypes.Nutrition;
                        }
                        break;
                      case 'Behavior':
                        {
                          selectedVideoType = videotypes.Behavior;
                        }
                        break;
                      case 'Hygiene':
                        {
                          selectedVideoType = videotypes.Hygiene;
                        }
                        break;
                      case 'Care Tips':
                        {
                          selectedVideoType = videotypes.CareTips;
                        }
                        break;
                      case 'Helpful Info':
                        {
                          selectedVideoType = videotypes.HelpfulInfo;
                        }
                        break;
                      case 'Nutritional Info':
                        {
                          selectedVideoType = videotypes.Nutrition;
                        }
                        break;
                      case 'Reptiles':
                        {
                          selectedVideoType = videotypes.Reptiles;
                        }
                        break;
                      case 'Rabbits':
                        {
                          selectedVideoType = videotypes.Rabbits;
                        }
                        break;
                      case 'Birds':
                        {
                          selectedVideoType = videotypes.Birds;
                        }
                        break;
                      case 'Rodents':
                        {
                          selectedVideoType = videotypes.Rodents;
                        }
                        break;
                      case 'Funny Pet Videos':
                        {
                          selectedVideoType = videotypes.Funny;
                        }
                        break;
                    }
                    _moveRight();
                  });
                }
              }),
        ),
      ],
    );
  }

  void loadVideoFromThumbnail(String video) {
    changeVideoAsset(video);
  }

  void changeVideoAsset(String videoName) {
    _chewieController.pause();
    _chewieController.dispose();
    _videoPlayerController1 = new VideoPlayerController.asset(videoName);
    // TODO figure out how to show big interactive play button in the middle of the video
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      showControls: true,
    );
  }

  void changeVideoFile(String videoName) {
    _chewieController.pause();
    _chewieController.dispose();
    _videoPlayerController1 = new VideoPlayerController.file(File(videoName));
    // TODO figure out how to show big interactive play button in the middle of the video
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

//  _getThumbnail(videoPathUrl) async {
//    final uint8list = await VideoThumbnail.thumbnailData(
//      video: videoPathUrl,
//      imageFormat: ImageFormat.JPEG,
//      maxHeightOrWidth: 128,
//      quality: 25,
//    );
//    return uint8list;
//  }

  BoxDecoration videoBorder() {
    return BoxDecoration(
      border: Border.all(color: const Color(0xFF503731), width: 6),
      borderRadius: BorderRadius.circular(12),
    );
  }

  // Getters
  ChewieController get chewieController => _chewieController;

  ScrollController get scrollController => _scrollController;

  VideoPlayerController get videoPlayerController1 => _videoPlayerController1;
  // Setters
  set chewieController(ChewieController value) {
    _chewieController = value;
  }

  set scrollController(ScrollController value) {
    _scrollController = value;
  }

  set videoPlayerController1(VideoPlayerController value) {
    _videoPlayerController1 = value;
  }
}

// TODO need to implement this for dog vs cat
//Widget _getImage(String name, String dir) {
//  if (_theme != AppTheme.candy) {
//    var file = _getLocalImageFile(name, _dir);
//    return Image.file(file);
//  }
//  return Image.asset('assets/images/$name');
//}

File _getLocalImageFile(String name, String dir) => File('$dir/$name');
File _getLocalFile(String name) => File(name);

read(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return json.decode(prefs.getString(key));
}

class PawsVideo {
  // TODO this is slightly off from the examples. Examples don't have this whack constructor
  PawsVideo(this.thumbnailName, this.name, this.thumbnailPath);

  String thumbnailName;
  String name;
  String thumbnailPath;

  PawsVideo.fromJson(Map<String, dynamic> json)
      : thumbnailName = json['thumbnailName'],
        name = json['name'],
        thumbnailPath = json['locathumbnailPathtion'];

  Map<String, dynamic> toJson() =>
      {'thumbnailName': thumbnailName, 'name': name, 'thumbnailPath': thumbnailPath};
}

class PawsVideoList {
  String listName;
  var pawsVideos = [];

  PawsVideoList();

  PawsVideoList.fromJson(Map<String, dynamic> json)
      : listName = json['listName'],
        pawsVideos = json['pawsVideos'];

  Map<String, dynamic> toJson() => {'listName': listName, 'PawsVideoList': pawsVideos};
}
