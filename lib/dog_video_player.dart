import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'play_pause_button.dart';
import 'base_video_player.dart';

class DogVideoPlayer extends VideoPlayerStatefulWidget {
  @override
  createState() => new DogVideoPlayerState();
}

// TODO inconsistent directory structure in PawsVideo objects
// TODO implement automatic PawsVideo object creation from asset folder.
// TODO maybe create a factory pattern to create PawsVideos from the internet vs folders?
// TODO implement for cat videos, any type of videos, really
class DogVideoPlayerState extends VideoPlayerStatefulWidgetState {

  @override
  void initState() {
    super.initState();
    videoPlayerController1 =
        VideoPlayerController.asset('assets/videos/funnydogscrylaughter.mp4');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
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

    // currently selected video list
    selectedVideoType = videotypes.Training;

    scrollController = ScrollController();
  }

  @override
  Widget createSideButtons() {
    return Container(
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
        ));
  }

  /**
   * Depending on the side button pressed, create a horizontal scroller with previews of videos
   */
  @override
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
      default:
        break;
    }
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

final List<PawsVideo> _trainingDogVideos = [
  PawsVideo('Housetrain', 'assets/videos/housetrain.mp4',
      'assets/antisocialthumbnail.jpg'), // Training
  PawsVideo('Aggressive dog', 'assets/videos/aggressivedog.mp4',
      'assets/Aggression.PNG'), // Training
  PawsVideo('Potty Training', 'assets/videos/pottytrain.mp4',
      'assets/pottytraining.PNG'),
];

final List<PawsVideo> _trickDogVideos = [
  PawsVideo('Teach Puppy Tricks', 'assets/videos/puppyliedown.mp4',
      'assets/LieDown.PNG'),
  PawsVideo('Paw Trick', 'assets/videos/pawtrick.mp4', 'assets/Shake.PNG'),
];

final List<PawsVideo> _socializationDogVideos = [
  PawsVideo('Puppy Socialization', 'assets/videos/earlypuppysocialization.mp4',
      'assets/Socialization.PNG'),
];

final List<PawsVideo> _funnyDogVideos = [
  PawsVideo('Funny dogs', 'assets/videos/funnydogscrylaughter.mp4',
      'assets/SocializationResearch.PNG'),
  PawsVideo('Guilty great dane', 'assets/videos/guiltydane.mp4',
      'assets/antisocialthumbnail.jpg'),
];

final List<PawsVideo> _localVideos = [
  PawsVideo(
      'NBA All-Star', 'assets/videos/nbaallstar.mp4', 'assets/AllStar.PNG'),
  PawsVideo('Residents Fear', 'assets/videos/traffic.mp4', 'assets/Traffic.PNG'),
  PawsVideo('Hurricane Dorian', 'assets/videos/dorian.mp4',
      'assets/LocalWeather.PNG'),
];

