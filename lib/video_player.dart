import 'dart:typed_data';

import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:video_thumbnail/video_thumbnail.dart';

enum videotypes {Tricks, Training, Socialization, Funny, Local}

class VideoPlayer extends StatefulWidget {
  @override
  createState() => new VideoPlayerState();
}

// TODO inconsistent directory structure in Dogvideo objects
// TODO implement automatic Dogvideo object creation from asset folder.
// TODO maybe create a factory pattern to create Dogvideos from the internet vs folders?
// TODO implement for cat videos, any type of videos, really
class VideoPlayerState extends State<VideoPlayer> {

  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  // currently selected video list
  videotypes selectedVideoType = videotypes.Training;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // background color
        color: Color(0xEF80D2F5),
        child: Column(children: [
          Padding(padding: EdgeInsets.all(25.0)),
          // side buttons
          Row(
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createSideButton('Tricks'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Training'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Socialization'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Funny Dogs'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Local Info'),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              )),
              // video player
              Expanded(
                child: Container(
                  padding: new EdgeInsets.all(32),
                  child: Center(
                    child: SizedBox(
                      height: 450,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // bottom horizontal scroller with videos to choose from
          Container(
            width: 800.0,
            height: 160.0,
            child: createCustomDynamicHorizontalImageScroller(),
          ),
        ]),
      ),
    );
  }

  /**
   * Depending on the side button pressed, create a horizontal scroller with previews of videos
   */
  Widget createCustomDynamicHorizontalImageScroller() {
    switch (selectedVideoType) {
      case videotypes.Tricks:
        {
          return createDynamicHorizontalImageScroller(_trickDogVideos);
        }
        break;
      case videotypes.Training:
        {
          return createDynamicHorizontalImageScroller(_trainingDogVideos);
        }
        break;
      case videotypes.Socialization:
        {
          return createDynamicHorizontalImageScroller(_socializationDogVideos);
        }
        break;
      case videotypes.Funny:
        {
          return createDynamicHorizontalImageScroller(_funnyDogVideos);
        }
        break;
      case videotypes.Local:
        {
          return createDynamicHorizontalImageScroller(_localVideos);
        }
        break;
    }
  }

  ListView createDynamicHorizontalImageScroller(List<Dogvideo> dogvideos) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dogvideos.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(children: [
            Container(
              width: 200.0,
              height: 120.0,
              padding: EdgeInsets.all(5.0),
              child: GestureDetector(
                  child: Container(
                    child: Image(
                      image: AssetImage(dogvideos[index].thumbnailPath),
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      changeVideo(dogvideos[index].name);
                    });
                  }),
            ),
            Text(
                dogvideos[index]
                    .thumbnailName, // Maybe use a key/value pair instead?
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ]);
        });
  }

  /**
   * No longer used. Dynamic image scroller is used instead.
   * Keeping because I still want to figure out how to generate a thumbnail dynamically.
   */
  ListView createHorizontalImageScroller() {
    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Column(children: [
          Container(
            width: 200.0,
            height: 120.0,
            padding: EdgeInsets.all(5.0),
            child: Image(
              image: MemoryImage(_getThumbnail(_trainingDogVideos[0]).then(() {
                return Uint8List;
              })),
              fit: BoxFit.contain,
              width: 200,
            ),
          ),
          Text('Rollover',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ]),
      ],
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
                    case 'Socialization':
                      {
                        selectedVideoType = videotypes.Socialization;
                      }
                      break;
                    case 'Funny Dogs':
                      {
                        selectedVideoType = videotypes.Funny;
                      }
                      break;
                    case 'Local Info':
                      {
                        selectedVideoType = videotypes.Local;
                      }
                      break;
                  }
                });
              }),
        ),
      ],
    );
  }

  void loadVideoFromThumbnail(String video) {
    changeVideo(video);
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.asset('assets/videos/housetrain.mp4');
    _videoPlayerController1.addListener(() {
      if (!_videoPlayerController1.value.isPlaying) {
        Navigator.pop(context);
      }
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      // Try playing around with some of these other options:

      showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  void changeVideo(String videoName) {
    _chewieController.pause();
    _chewieController.dispose();
    _videoPlayerController1 = new VideoPlayerController.asset(videoName);
    // TODO figure out how to show big interactive play button in the middle of the video
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
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

  _getThumbnail(videoPathUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPathUrl,
      imageFormat: ImageFormat.JPEG,
      maxHeightOrWidth: 128,
      quality: 25,
    );
    return uint8list;
  }
}

final List<Dogvideo> _trainingDogVideos = [
  Dogvideo('Housetrain',
      'assets/videos/housetrain.mp4',
      'assets/antisocialthumbnail.jpg'), // Training
  Dogvideo('Aggressive dog',
      'assets/videos/aggressivedog.mp4',
      'assets/Aggression.PNG'), // Training
  Dogvideo('Potty Training',
      'assets/videos/pottytrain.mp4',
      'assets/pottytraining.PNG'),
];

final List<Dogvideo> _trickDogVideos = [
  Dogvideo('Teach Puppy Tricks',
      'assets/videos/puppyliedown.mp4',
      'assets/LieDown.PNG'),
  Dogvideo('Paw Trick',
      'assets/videos/pawtrick.mp4',
      'assets/Shake.PNG'),
  Dogvideo('Teach roll over',
      'assets/videos/rollover.mp4',
      'assets/RollOver.PNG'),
];

final List<Dogvideo> _socializationDogVideos = [
  Dogvideo('Socialize Puppy',
      'assets/videos/socializepuppy.mp4',
      'assets/SocializationResearch.PNG'),
  Dogvideo(
      'Puppy Socialization',
      'assets/videos/earlypuppysocialization.mp4',
      'assets/Socialization.PNG'),
];

final List<Dogvideo> _funnyDogVideos = [
  Dogvideo(
      'Funniest Confused Pets',
      'assets/videos/funniestconfusedpets.mp4',
      'assets/Socialization.PNG'),
  Dogvideo(
      'Funny dogs',
      'assets/videos/funnydogscrylaughter.mp4',
      'assets/SocializationResearch.PNG'),
  Dogvideo(
      'Funny dogs talking',
      'assets/videos/funnydogstalking.mp4',
      'assets/Arguing.PNG'),
  Dogvideo('Guilty great dane', 'assets/videos/guiltydane.mp4',
      'assets/antisocialthumbnail.jpg'),
  Dogvideo(
      'Funny bulldog',
      'assets/videos/funnybulldog.mp4',
      'assets/FunnyBulldogs.PNG'),
  Dogvideo('Hangry dog Reuben', 'assets/videos/reubenhangrydog.mp4',
      'assets/HangryDog.PNG'),
];

final List<Dogvideo> _localVideos = [
  Dogvideo('NBA All-Star', 'assets/videos/nbaallstar.mp4','assets/AllStar.PNG'),
  Dogvideo('Residents Fear', 'assets/videos/traffic.mp4', 'assets/Traffic.PNG'),
  Dogvideo('Hurricane Dorian', 'assets/videos/dorian.mp4', 'assets/LocalWeather.PNG'),
];

class Dogvideo {
  const Dogvideo(this.thumbnailName, this.name, this.thumbnailPath);

  final String thumbnailName;
  final String name;
  final String thumbnailPath;
}
