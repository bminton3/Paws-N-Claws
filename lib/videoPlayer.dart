import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  @override
  createState() => new VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xAF65CAE0),
        child: Row(
          children: [
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 60,
                  child: CupertinoButton(
                    color: Color(0xFFA2CAC9),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Potty Training',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: buttonPress,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                SizedBox(
                  width: 180,
                  height: 60,
                  child: CupertinoButton(
                    color: Color(0xFFA2CAC9),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Tricks',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: buttonPress,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                SizedBox(
                  width: 180,
                  height: 60,
                  child: CupertinoButton(
                    color: Color(0xFFA2CAC9),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Nutrition',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: buttonPress,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                SizedBox(
                  width: 180,
                  height: 60,
                  child: CupertinoButton(
                    color: Color(0xFFA2CAC9),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Socialization',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: buttonPress,
                  ),
                ),
              ],
            )),
            Expanded(
              child: Container(
                padding: new EdgeInsets.all(32),
                child: Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonPress() {
    print("This button will do something later");
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.asset('assets/potty.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      // Try playing around with some of these other options:

      // showControls: false,
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

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
