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
        color: Color(0xEF80D2F5),
        child: Column(children: [
          Padding(padding: EdgeInsets.all(25.0)),
          Row(
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createSideButton('Tricks'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Potty Training'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Nurtition'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Socialization'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Funny Dogs'),
                  Padding(padding: EdgeInsets.all(5.0)),
                  createSideButton('Local Info'),
                  Padding(padding: EdgeInsets.all(5.0)),
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
          Container(
            width: 800.0,
            height: 160.0,
            child: createHorizontalImageScroller(),
          ),
        ]),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

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
              image: AssetImage('assets/previewOne.jpg'),
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
        Column(children: [
          Container(
            width: 200.0,
            height: 120.0,
            padding: EdgeInsets.all(5.0),
            child: Image(
              image: AssetImage('assets/previewTwo.jpg'),
              fit: BoxFit.contain,
              width: 200,
            ),
          ),
          Text('Sit',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ]),
        Column(children: [
          Container(
            width: 200.0,
            height: 120.0,
            padding: EdgeInsets.all(5.0),
            child: Image(
              image: AssetImage('assets/previewThree.jpg'),
              fit: BoxFit.contain,
              width: 200,
            ),
          ),
          Text('Fetch',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ]),
        Column(children: [
          Container(
            width: 200.0,
            height: 120.0,
            padding: EdgeInsets.all(5.0),
            child: Image(
              image: AssetImage('assets/previewFour.jpg'),
              fit: BoxFit.contain,
              width: 200,
            ),
          ),
          Text('Lay Down',
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
            // TODO there's gotta be a better way to do this
            onTap: () => buttonPress,
          ),
        ),
      ],
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
