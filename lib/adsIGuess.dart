import 'package:flutter/material.dart';

class AdsIGuess extends StatefulWidget {
  @override
  createState() => new AdsIGuessState();
}

class AdsIGuessState extends State<AdsIGuess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ads? Videos? Textual information?"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Center(
          child: Text('We need to talk about content'),
        ),
      ),
    );
  }
}
