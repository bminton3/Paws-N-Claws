import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'play_pause_button.dart';

enum videotypes { Tricks, Training, Socialization, Funny, Local, Nutrition, Behavior, Hygiene }

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


  // currently selected video list
  videotypes selectedVideoType = videotypes.Training;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

              // video player
              Expanded(
                child: Container(
                  padding: new EdgeInsets.all(32),
                  child: Center(
                    child: SizedBox(
                      height: 450,
                      child: VideoPlayPause(_videoPlayerController1),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // bottom horizontal scroller with videos to choose from
          Row(children: [
            //Padding(padding: EdgeInsets.only(right: 30.0)),

            // left arrow
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 119.0,
                height: 130.0,
                // doesn't have size
                child: GestureDetector(
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/leftarrow.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  // TODO there's gotta be a better way to do this
                  onTap: () => _moveLeft(),
                ),
              ),
            ),

            // videos
            Expanded(
              flex: 3,
              child: Container(
                width: 650.0,
                height: 160.0,
                child: createCustomDynamicHorizontalImageScroller(),
              ),
            ),

            // right arrow
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 119.0,
                height: 130.0,
                // doesn't have size
                child: GestureDetector(
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/rightarrow.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  // TODO there's gotta be a better way to do this
                  onTap: () => _moveRight(),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  /// To be overridden by child classes
  Widget createSideButtons() {

  }

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
  Widget createCustomDynamicHorizontalImageScroller() {  }

  ListView createDynamicHorizontalImageScroller(List<PawsVideo> pawsvideos) {
    return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: pawsvideos.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(children: [
            Container(
              width: 200.0,
              height: 120.0,
              padding: EdgeInsets.all(5.0),
              child: GestureDetector(
                  child: Container(
                    child: Image(
                      image: AssetImage(pawsvideos[index].thumbnailPath),
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      changeVideo(pawsvideos[index].name);
                    });
                  }),
            ),
            Text(
                pawsvideos[index]
                    .thumbnailName, // Maybe use a key/value pair instead?
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ]);
        });
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
                  }
                  _moveRight();
                });
              }),
        ),
      ],
    );
  }

  void loadVideoFromThumbnail(String video) {
    changeVideo(video);
  }

  void changeVideo(String videoName) {
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
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

class PawsVideo {
  const PawsVideo(this.thumbnailName, this.name, this.thumbnailPath);

  final String thumbnailName;
  final String name;
  final String thumbnailPath;
}

enum VideoType {
  dog,
  cat
}
