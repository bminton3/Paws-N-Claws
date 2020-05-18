import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FrostedGlassScreensaver extends StatefulWidget {
  int timer = 30;
  bool visible = false;

  FrostedGlassScreensaver(int timer) {
    this.timer = timer;
  }

  @override
  createState() => new FrostedGlassScreensaverState(timer);
}

class FrostedGlassScreensaverState extends State<FrostedGlassScreensaver> {
  bool visible = false;
  int timer = 30;
  RestartableTimer popupTimer;
  RestartableTimer resetTimer;

  FrostedGlassScreensaverState(int timer) {
    print('starting timer');
    // if we haven't started a timer already, start one with timer parameter duration
    popupTimer = RestartableTimer(Duration(seconds: timer), () {
            _setVisible(true);
            resetTimer = RestartableTimer(Duration(seconds: timer),
                    () {
                        print('going back to home screen!');
                        Navigator.of(context).pushNamed('/homeScreen');
                    });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: Center(
                        child: Image.asset(
                      "assets/puppyLicking.gif",
                      height: 350.0,
                      width: 350.0,
                    )),
                  ),
                ),
              ),
              onTap: () {
                resetTimer == null ? print('null reset timer') : resetTimer.cancel();
                visible = false;
                popupTimer == null ? print('null popup timer reset') : popupTimer.cancel();
                setState(() {});
              },
            ),
            Positioned(
              bottom: 150,
              child: Align(
                alignment: Alignment.center,
                child: Text("Tap to continue",
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(100),
                      fontFamily: 'Marydale',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.grey,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
              top: 150,
              child: Align(
                alignment: Alignment.center,
                child: Text("Are you still there?",
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(100),
                      fontFamily: 'Marydale',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.grey,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setVisible(bool visible) {
    this.visible = visible;
    setState(() {});
  }
}
