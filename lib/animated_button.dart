import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dog_age_input_screen.dart';

class PawsAnimatedButton extends StatefulWidget {

  final String url;

  PawsAnimatedButton(@required this.url);

  @override
  _PawsAnimatedButtonState createState() => _PawsAnimatedButtonState(url);
}

// ======== Animated button =====ß
class _PawsAnimatedButtonState extends State<PawsAnimatedButton> with SingleTickerProviderStateMixin {
  // field holds the url passed in
  final String url;

  _PawsAnimatedButtonState (@required this.url);

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
          onTap: () => _onDogBreedClicked(url),
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

  void _onDogBreedClicked(url) {
    switch(url) {
      case 'assets/dogbuttonresized.png':
        Navigator.of(context).pushNamed('/dogAgeInput');
        break;
      case 'assets/catbutton.png':
        Navigator.of(context).pushNamed('/catAgeInput');
        break;
      default:
        Navigator.of(context).pushNamed('/dogAgeInput');
    }
  }

}