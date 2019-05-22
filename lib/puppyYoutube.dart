import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class PuppyYoutubeWidget extends StatefulWidget {
  @override
  createState() => new PuppyYoutubeWidgetState();
}

class PuppyYoutubeWidgetState extends State<PuppyYoutubeWidget> {
  YoutubePlayerController _controller = YoutubePlayerController();
  var _idController = TextEditingController();
  var _seekToController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";

  String _videoId = "iLnmTe5Q2Qw";

  void listener() {
    setState(() {
      _playerStatus = _controller.value.playerState.toString();
    });
  }

  @override
  void deactivate() {
    // This pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch some videos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YoutubePlayer(
              context: context,
              videoId: _videoId,
              autoPlay: true,
              showVideoProgressIndicator: true,
              videoProgressIndicatorColor: Colors.amber,
              progressColors: ProgressColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onPlayerInitialized: (controller) {
                _controller = controller;
                _controller.addListener(listener);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter youtube \<video id\> or \<link\>"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _videoId = _idController.text;
                        // If text is link then converting to corresponding id.
                        if (_videoId.contains("http"))
                          _videoId = YoutubePlayer.convertUrlToId(_videoId);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      color: Colors.amber,
                      child: Text(
                        "PLAY",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.play_arrow
                              : Icons.pause,
                        ),
                        onPressed: () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                        onPressed: () {
                          _muted ? _controller.unMute() : _controller.mute();
                          setState(() {
                            _muted = !_muted;
                          });
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.fullscreen),
                          onPressed: () => _controller.enterFullScreen()),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _seekToController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Seek to seconds",
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: OutlineButton(
                          child: Text("Seek"),
                          onPressed: () => _controller.seekTo(
                                Duration(
                                  seconds: int.parse(_seekToController.text),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: (value) {
                            setState(() {
                              _volume = value;
                            });
                            _controller.setVolume(_volume.round());
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Status: $_playerStatus",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
