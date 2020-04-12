import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'play_pause_button.dart';
import 'base_video_player.dart';

class CatVideoPlayer extends VideoPlayerStatefulWidget {
  @override
  createState() => new CatVideoPlayerState();
}

// TODO inconsistent directory structure in PawsVideo objects
// TODO implement automatic PawsVideo object creation from asset folder.
// TODO maybe create a factory pattern to create PawsVideos from the internet vs folders?
// TODO implement for cat videos, any type of videos, really
class CatVideoPlayerState extends VideoPlayerStatefulWidgetState {

  @override
  void initState() {
    super.initState();
    videoPlayerController1 =
        VideoPlayerController.asset('assets/videos/catscratching.mp4');
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
    selectedVideoType = videotypes.Behavior;

    scrollController = ScrollController();
  }

  @override
  Widget createSideButtons() {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createSideButton('Nutrition'),
            Padding(padding: EdgeInsets.all(5.0)),
            createSideButton('Behavior'),
            Padding(padding: EdgeInsets.all(5.0)),
            createSideButton('Hygiene'),
            Padding(padding: EdgeInsets.all(5.0)),
            createSideButton('Funny Cats'),
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
      case videotypes.Nutrition:
        {
          return createDynamicHorizontalImageScroller(_nutritionVideos);
        }
        break;
      case videotypes.Behavior:
        {
          return createDynamicHorizontalImageScroller(_behaviorVideos);
        }
        break;
      case videotypes.Hygiene:
        {
          return createDynamicHorizontalImageScroller(_hygieneVideos);
        }
        break;
      case videotypes.Funny:
        {
          return createDynamicHorizontalImageScroller(_funnyVideos);
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

final List<PawsVideo> _behaviorVideos = [
  PawsVideo('Stop Scratching', 'assets/videos/catscratching.mp4',
      'assets/catscratching.jpeg'),
  PawsVideo('Understand Your Cat', 'assets/videos/understandcat.mp4',
      'assets/understandcat.jpeg'),
];

final List<PawsVideo> _nutritionVideos = [
  PawsVideo('Homemade Treats', 'assets/videos/cattreats.mp4',
      'assets/cattreats.jpeg'),
  PawsVideo('How to feed', 'assets/videos/feedcat.mp4', 'assets/feedcat.jpeg'),
];

final List<PawsVideo> _hygieneVideos = [
  PawsVideo('Cat Hygiene Tips', 'assets/videos/cathygienetips.mp4',
      'assets/cathygienetips.jpeg'),
  PawsVideo('Cat Care 101', 'assets/videos/catcare101.mp4',
      'assets/catcare101.jpeg'),
];

final List<PawsVideo> _funnyVideos = [
  PawsVideo('Funniest Cats', 'assets/videos/funniestcat.mp4',
      'assets/funniestcat.jpeg'),
  PawsVideo('Funny Baby Cat', 'assets/videos/babycat.mp4',
      'assets/babycat.jpeg'),
];

final List<PawsVideo> _localVideos = [
  PawsVideo(
      'Local Guide', 'assets/videos/charlotteguide.mp4', 'assets/charlotteguide.jpeg'),
  PawsVideo('Father Recovers', 'assets/videos/covid19.mp4', 'assets/covid19.jpeg'),
];

