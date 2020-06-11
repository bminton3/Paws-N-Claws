import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

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
    // load files to play
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      file = io.Directory("assets/videos/Dog/Care Tips").listSync();
    });
  }

  @override
  Widget createSideButtons() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createSideButton('General Health'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Care Tips'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Helpful Info'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Nutritional Info'),
        Padding(padding: EdgeInsets.all(5.0)),
      ],
    ));
  }

  /**
   * Depending on the side button pressed, create a horizontal scroller with previews of videos
   * base_video_player.createSideButton will change the selectedVideoType during the onTap() function
   */
  @override
  Widget createCustomDynamicHorizontalImageScroller() {
    switch (selectedVideoType) {
      case videotypes.GeneralHealth:
        {
          return createDynamicHorizontalImageScroller(_generalhealthVideos);
        }
        break;
      case videotypes.CareTips:
        {
          return createDynamicHorizontalImageScroller(_caretipsVideos);
        }
        break;
      case videotypes.HelpfulInfo:
        {
          return createDynamicHorizontalImageScroller(_helpfulinfoVideos);
        }
        break;
      case videotypes.Nutrition:
        {
          return createDynamicHorizontalImageScroller(_nutritionalinfoVideos);
        }
        break;
      default:
        break;
    }
  }
}

final List<PawsVideo> _caretipsVideos = [
  PawsVideo('Anxious Cat', 'assets/videos/Cat/caretips/Anixouscat.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/Anxious.JPG'),
  PawsVideo('10 Care Tips', 'assets/videos/Cat/caretips/Cat10Tips.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/10tips.JPG'),
  PawsVideo('Cat Nail Care', 'assets/videos/Cat/caretips/Catnails.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/Nails.JPG'),
  PawsVideo('Giving a Cat Pills', 'assets/videos/Cat/caretips/Catpill.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/Catpill.JPG'),
  PawsVideo(
      'Checking for Fleas',
      'assets/videos/Cat/caretips/Checkforfleas.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/Fleas.JPG'),
  PawsVideo('Litter Box', 'assets/videos/Cat/caretips/Litterboxoder.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/6tips.JPG'),
  PawsVideo('Teeth Cleaning', 'assets/videos/Cat/caretips/TeethCleaning.mp4',
      'assets/videos/Cat/caretips/catcarethumbnails/Teethcleaning.JPG'),
];

final List<PawsVideo> _generalhealthVideos = [
  PawsVideo('Cat Stress', 'assets/videos/Cat/generalhealth/3catstress.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/3stress.JPG'),
  PawsVideo(
      'Cat Constipation',
      'assets/videos/Cat/generalhealth/CatConstipation.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/catconsti.JPG'),
  PawsVideo('Cat Digestion', 'assets/videos/Cat/generalhealth/Catpoopblood.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/Catpoop.JPG'),
  PawsVideo('Cat Pregnancy', 'assets/videos/Cat/generalhealth/CatPregnancy.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/Pregocat.JPG'),
  PawsVideo(
      'Kitten Health Problems',
      'assets/videos/Cat/generalhealth/KittenHealthProblems.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/Healthproblems.JPG'),
  PawsVideo(
      'When to Neuter',
      'assets/videos/Cat/generalhealth/WhenNeuterCat.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/Neuter.JPG'),
  PawsVideo('Hungry Cat', 'assets/videos/Cat/generalhealth/whycathungry.mp4',
      'assets/videos/Cat/generalhealth/generalhealththumbnails/hungry.JPG'),
];

final List<PawsVideo> _helpfulinfoVideos = [
  PawsVideo('7 Things', 'assets/videos/Cat/helpfulinfo/7thingscatowners.mp4',
      'assets/videos/Cat/helpfulinfo/cathelpfulinfothumbnails/7things.JPG'),
  PawsVideo(
      'How to Pickup a Cat',
      'assets/videos/Cat/helpfulinfo/Pickupcat.mp4',
      'assets/videos/Cat/helpfulinfo/cathelpfulinfothumbnails/Pickup.JPG'),
  PawsVideo('Cat Love', 'assets/videos/Cat/helpfulinfo/3catlove.mp4',
      'assets/videos/Cat/helpfulinfo/cathelpfulinfothumbnails/love.JPG'),
  PawsVideo(
      'Stop Cat Climbing on Furniture',
      'assets/videos/Cat/helpfulinfo/Stopcatfurniture.mp4',
      'assets/videos/Cat/helpfulinfo/cathelpfulinfothumbnails/climbing.JPG'),
  PawsVideo(
      'How to Travel With a Cat',
      'assets/videos/Cat/helpfulinfo/Travelwithcat.mp4',
      'assets/videos/Cat/helpfulinfo/cathelpfulinfothumbnails/Traveling.JPG'),
];

final List<PawsVideo> _nutritionalinfoVideos = [
  PawsVideo(
      '3 Foods to Never Feed Your Cat',
      'assets/videos/Cat/nutritionalinfo/3foodsnever.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/badfood.JPG'),
  PawsVideo('Cat Diet', 'assets/videos/Cat/nutritionalinfo/Catdiet.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/diet.JPG'),
  PawsVideo(
      'What If Cat Eats Dog Food',
      'assets/videos/Cat/nutritionalinfo/Catdogfood.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/Catdogfood.JPG'),
  PawsVideo('Cat Eats Grass', 'assets/videos/Cat/nutritionalinfo/Catgrass.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/Grass.JPG'),
  PawsVideo(
      'Cat Not Eating',
      'assets/videos/Cat/nutritionalinfo/Catnoteating.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/noteating.JPG'),
  PawsVideo(
      'Healthy Fruit for Cat',
      'assets/videos/Cat/nutritionalinfo/Healthyfruitcat.mp4',
      'assets/videos/Cat/nutritionalinfo/catnutritionalinfothumbnails/Fruits.JPG'),
];
