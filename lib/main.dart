import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dog_age_input_screen.dart';
import 'cat_age_input_screen.dart';
import 'animated_button.dart';
import 'dog_video_player.dart';
import 'cat_video_player.dart';

enum pettypes { dog, cat, other }

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  final String _title = 'Paws and Claws Media';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(fontFamily: 'Marydale'),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/homeScreen': (BuildContext context) => new HomeScreen(),
        '/dogAgeInput': (BuildContext context) => new DogAgeDropDown(),
        '/catAgeInput': (BuildContext context) => new CatAgeDropDown(),
        '/otherPet': (BuildContext context) => new DogAgeDropDown(),
        '/dogVideoPlayer': (BuildContext context) => new DogVideoPlayer(),
        '/catVideoPlayer': (BuildContext context) => new CatVideoPlayer(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('height:  ${MediaQuery.of(context).size.height}');
    log('width:  ${MediaQuery.of(context).size.width}');
    log('bottom padding: ${MediaQuery.of(context).padding.bottom}');
    log('top padding: ${MediaQuery.of(context).padding.top}');
    // pixel 3: 1080 x 2160
    // ipad 6: 1536 x 2048
    double defaultScreenWidth = 2048.0;
    double defaultScreenHeight = 1536.0;
    // wtf does ..init do?
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return PawsAndClaws();
  }
}

class PawsAndClawsState extends State<PawsAndClaws> {
  final List<String> _pets = [
    'assets/dogbuttonresized.png',
    'assets/catbutton.png',
    //'assets/otherbutton.png'
  ];

  final List<Text> _dogBreeds = [
    Text("English Bulldog"),
    Text("Golden Retriever"),
    Text("German Shepard"),
    Text("Black Labrador")
  ];

  // HACK: Widgets only get rebuilt when there is a change in its state. Slider had to set
  // an instance variable's value to work
  double _age = 1;

  // Ideas to get the frosted glass to disappear on tap and reappear after idle:
  // 1. Make it a stateful widget and have visible a member variable. Who manages bringing it back, though? A timer inside itself?
  // 2.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      _buildPetIcons(context),
      //new FrostedGlassScreensaver(),
    ]));
  }

  // TODO implement OrientationBuilder - do I still need this? This was for autoorientation
  Widget _buildPetIcons(BuildContext context) {
    return Container(
        // new color
        decoration: BoxDecoration(color: Color(0xEF80D2F5)),
        child: _buildTappableButtons(context));
  }

  /**
   * TODO need to add text above the buttons but columns are fucking impossible
   */
  Widget _buildTappableButtons(BuildContext context) {
    // TODO we may not want a GridView because it's scrollable. May be fun for the users, though
    return Column(children: [
      Padding(padding: EdgeInsets.all(ScreenUtil.instance.setWidth(50.0))),

      // text above pet buttons
      Text('What type of best friend do you want?',
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
//      Text('(tap your pet below)',
//          style: TextStyle(
//              fontSize: ScreenUtil.instance.setSp(42.0),
//              fontFamily: 'Arial',
//              color: Colors.white)),

      // pet buttons
      Column(children: [
        Row(children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: 500,
              child: PawsAnimatedButton(_pets[0]),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: 500,
              child: PawsAnimatedButton(_pets[1]),
            ),
          )
        ])
      ]),
//      Column(children: [
//        Row(children: <Widget>[
//          Container(
//            alignment: Alignment.center,
//            width: 480,
//            height: 120,
//            child: Text(
//              'dog',
//              style: TextStyle(
//                  fontSize: ScreenUtil.instance.setSp(145.0),
//                  fontFamily: 'Marydale',
//                  fontWeight: FontWeight.w700,
//                  color: Colors.white),
//            ),
//          ),
//          Container(
//            alignment: Alignment.center,
//            width: 480,
//            height: 120,
//            child: Text('cat',
//                style: TextStyle(
//                    fontSize: ScreenUtil.instance.setSp(145.0),
//                    fontFamily: 'Marydale',
//                    fontWeight: FontWeight.w700,
//                    color: Colors.white)),
//          ),
//        ])
//      ])
    ]);
  }

// ======== Age Slider =============
  Widget createAgeSlider() {
    return Slider(
      activeColor: Colors.blueGrey,
      value: _age,
      onChanged: (double sliderAge) {
        setState(() {
          print('user has clicked the slider!');
          _age = sliderAge;
        });
      },
      min: 0.0,
      max: 20.0,
      divisions: 4,
    );
  }


}

// ======== Globals =============ß
// main stateful widget
class PawsAndClaws extends StatefulWidget {
  @override
  PawsAndClawsState createState() => PawsAndClawsState();
}

//======= Colors ========
// Colors.white for specific named colors
// Color(0xhex) for custom colors

// 0xFF65CAE0 - light blue?
// 0xFFA2CAC9 - teal?
// 0xFFD9DDC5 - tan
// 0xFFEB822F - orange
// 0xFFF26600 - bright orange
// 0xFF694533 - brown
// the first 2 digits are transparency.

// TODO naming routes. May be needed later
/*void main() {
  runApp(MaterialApp(
    home: MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => MyPage(title: 'page A'),
      '/b': (BuildContext context) => MyPage(title: 'page B'),
      '/c': (BuildContext context) => MyPage(title: 'page C'),
    },
  ));
}*/

// button ideas: OutlineButton, IconButton (probably this one)
// layout ideas: gridview
