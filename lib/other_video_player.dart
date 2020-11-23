import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'base_video_player.dart';

bool _debug;

String _dir;

String defaultVideo = 'assets/Dogcar.mp4';

class OtherVideoPlayer extends VideoPlayerStatefulWidget {
  @override
  createState() => new OtherVideoPlayerState();
}

// TODO inconsistent directory structure in PawsVideo objects
// TODO implement automatic PawsVideo object creation from asset folder.
// TODO maybe create a factory pattern to create PawsVideos from the internet vs folders?
// TODO implement for cat videos, any type of videos, really
class OtherVideoPlayerState extends VideoPlayerStatefulWidgetState {
  @override
  void initState() {
    super.initState();
    _debug = true;
    videoPlayerController1 = VideoPlayerController.asset(defaultVideo);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
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
    selectedVideoType = videotypes.CareTips;

    scrollController = ScrollController();
  }

  @override
  Widget createSideButtons() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createSideButton('Reptiles'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Rabbits'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Birds'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Rodents'),
        Padding(padding: EdgeInsets.all(5.0)),
        createSideButton('Funny Pet Videos'),
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
      case videotypes.Reptiles:
        {
          if (_debug) {
            debugDumpApp();
          }
          return createDynamicHorizontalImageScroller(util.funnydogvideos);
        }
        break;
      case videotypes.Rabbits:
        {
          if (_debug) {
            debugDumpApp();
          }
          return createDynamicHorizontalImageScroller(util.funnydogvideos);
        }
        break;
      case videotypes.Birds:
        {
          if (_debug) {
            debugDumpApp();
          }
          return createDynamicHorizontalImageScroller(util.funnydogvideos);
        }
        break;
      case videotypes.Funny:
        {
          if (_debug) {
            debugDumpApp();
          }
          return createDynamicHorizontalImageScroller(util.funnydogvideos);
        }
        break;
      case videotypes.Rodents:
        {
          if (_debug) {
            debugDumpApp();
          }
          return createDynamicHorizontalImageScroller(util.funnydogvideos);
        }
        break;
      default:
        break;
    }
  }
}

final List<PawsVideo> _careTipsVideos = [
  PawsVideo('Get Out of Vehicle', 'assets/videos/dog/Dogcar.mp4', '$_dir/test/Dogincar.JPG'),
];

//final List<PawsVideo> _careTipsVideos = [
//  PawsVideo(
//      'Allergic Reaction',
//      'assets/videos/dog/caretips/DogSkinAllergy.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/skinallergies.jpg'),
//  PawsVideo('Teeth Cleaning', 'assets/videos/dog/caretips/DogcatTeeth.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/teethcleaning.jpg'),
//  PawsVideo('Wash Your Dog', 'assets/videos/dog/caretips/Dogwash.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dogwash.jpg'),
//  PawsVideo('Dog Nail Care', 'assets/videos/dog/caretips/Dognails.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dognails.jpg'),
//  PawsVideo('Stop a Dog Fight', 'assets/videos/dog/caretips/Dogfight.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dogfight.jpg'),
//  PawsVideo(
//      'Stop Separation Anxiety',
//      'assets/videos/dog/caretips/Seperation1.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dogseparation1.jpg'),
//  PawsVideo(
//      'Stop Separation Anxiety 2',
//      'assets/videos/dog/caretips/Seperation2.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dogseparation2.jpg'),
//  PawsVideo('Get Out of Vehicle', 'assets/videos/dog/caretips/Dogcar.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/doggettingoutofcar.jpg'),
//  PawsVideo(
//      'Revolution Reaction',
//      'assets/videos/dog/caretips/Allergicreaction.mp4',
//      'assets/videos/dog/caretips/caretipsthumbnails/dogallergicreaction.jpg')
//];
//
final List<PawsVideo> _funnyDogVideos = [];
//final List<PawsVideo> _funnyDogVideos = [
//  PawsVideo('Corgi Beach Day', 'assets/videos/dog/funnydogvideos/DogBeach.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/beachdog.jpg'),
//  PawsVideo('Corgi Pool Party', 'assets/videos/dog/funnydogvideos/Dogpool.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/DogPool.jpg'),
//  PawsVideo(
//      'Doggy Christmas',
//      'assets/videos/dog/funnydogvideos/Dogchristmas.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/Dogxmas.jpg'),
//  PawsVideo('Dog Dino', 'assets/videos/dog/funnydogvideos/Dogdino.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/Doggydino.jpg'),
//  PawsVideo(
//      'Presents for Pup',
//      'assets/videos/dog/funnydogvideos/Dogpresents.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/Dogpresents.jpg'),
//  PawsVideo('Halloween', 'assets/videos/dog/funnydogvideos/Halloween.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/DogHalloween.jpg'),
//  PawsVideo('Dog Micky', 'assets/videos/dog/funnydogvideos/Micky.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/Dogmicky.jpg'),
//];
//
final List<PawsVideo> _generalHealthDogVideos = [];
//final List<PawsVideo> _generalHealthDogVideos = [
//  PawsVideo('Arthritis', 'assets/videos/dog/generalhealth/Arthritis.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Arth.JPG'),
//  PawsVideo('Dog Fleas', 'assets/videos/dog/generalhealth/Dogfleas.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Fleas.JPG'),
//  PawsVideo('Arthritis', 'assets/videos/dog/generalhealth/DogNeeds.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Dogneeds.JPG'),
//  PawsVideo('Arthritis', 'assets/videos/dog/generalhealth/Properfeed.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Dogfeed.JPG'),
//  PawsVideo('Arthritis', 'assets/videos/dog/generalhealth/Socialization.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Socialization.jpg'),
//  PawsVideo('Arthritis', 'assets/videos/dog/generalhealth/Takecontrol.mp4',
//      'assets/videos/dog/generalhealth/healththumbnails/Takecontrol.JPG'),
//];
//
final List<PawsVideo> _trainingDogVideos = [];
//final List<PawsVideo> _trainingDogVideos = [
//  PawsVideo('Teach Come', 'assets/videos/dog/training/Come.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Come.JPG'),
//  PawsVideo('Drop it', 'assets/videos/dog/training/Dropit.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Dropit.JPG'),
//  PawsVideo('Equipment', 'assets/videos/dog/training/Equipment.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Equip.JPG'),
//  PawsVideo('Fireworks', 'assets/videos/dog/training/Fireworks.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Fireworks.JPG'),
//  PawsVideo('Front Door', 'assets/videos/dog/training/Frontdoor.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Door.JPG'),
//  PawsVideo('Go to Bed', 'assets/videos/dog/training/Gotobed.mp4',
//      'assets/videos/dog/training/trainingthumbnails/gotobed.JPG'),
//  PawsVideo('Puppy Down', 'assets/videos/dog/training/puppydown.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Lay.JPG'),
//  PawsVideo('Verbal Commands', 'assets/videos/dog/training/Verbalcommands.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Verbal.JPG'),
//  PawsVideo('Potty Train', 'assets/videos/dog/training/Potty.mp4',
//      'assets/videos/dog/training/trainingthumbnails/Potty.JPG'),
//];
//
final List<PawsVideo> _tricksDogVideos = [];
//final List<PawsVideo> _tricksDogVideos = [
//  PawsVideo('Corgi Beach Day', 'assets/videos/dog/funnydogvideos/DogBeach.mp4',
//      'assets/videos/dog/funnydogvideos/funnythumbnails/beachdog.jpg'),
//];
