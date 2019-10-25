import 'package:flutter/material.dart';
import 'age_input_screen.dart';
import 'dart:ui';
import 'frosted_glass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer';
import 'dart:async';

class AnimatedButton extends StatefulWidget {

  final String url;

  AnimatedButton(@required this.url);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState(url);
}

// ======== Animated button =====ß
class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  // field holds the url passed in
  final String url;

  _AnimatedButtonState (@required this.url);

  double _scale;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: GestureDetector(
          child: Container(
            child: Image(
              image: AssetImage(url),
              fit: BoxFit.scaleDown,
            ),
          ),
          // TODO there's gotta be a better way to do this
          onTap: () => _onDogBreedClicked(null),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.1,
    )
      ..addListener(() {
        Timer(Duration(milliseconds: 50), () { // if this actually works...
          setState(() {});
        },);}); // once again, what does .. mean? And I forget what {} vs => means
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onDogBreedClicked(index) {
    print("You selected a breed");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => new DogAgeDropDown(),
      ),
    );
  }

}