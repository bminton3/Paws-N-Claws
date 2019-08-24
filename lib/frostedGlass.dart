import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:async/async.dart';

class FrostedGlassScreensaver extends StatefulWidget {
  @override
  createState() => new FrostedGlassScreensaverState();
}

class FrostedGlassScreensaverState extends State<FrostedGlassScreensaver> {
  bool visible = true;
  static const timeout = const Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Center(
        child: GestureDetector(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                child: Center(
                  child: Image.asset(
                    "assets/puppyLicking.gif",
                    height: 350.0,
                    width: 350.0,
                  )
                ),
              ),
            ),
          ),
          onTap: () {
            visible = false;
            setState(() {
            });
            startRestartableTimer();
          },
        ),
      ),
    );
  }

  void startRestartableTimer() {
    RestartableTimer(Duration(seconds: 30), () => setVisible(true));
  }

  void setVisible(bool visible) {
    this.visible = visible;
    setState(() {
    });
  }
}
