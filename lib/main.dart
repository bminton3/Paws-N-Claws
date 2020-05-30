import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_vet_tv/shared_preferences_helper.dart';

import 'dog_age_input_screen.dart';
import 'cat_age_input_screen.dart';
import 'animated_button.dart';
import 'dog_video_player.dart';
import 'cat_video_player.dart';
import 'frosted_glass.dart';
import 'settings_page.dart';
import 'util.dart';

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
        '/settingsPage': (BuildContext context) => new SettingsPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: PreferredSize(
//          preferredSize: Size.fromHeight(85.0),
//          child: AppBar(
//              elevation: 0.0,
//              bottomOpacity: 0.0,
//              backgroundColor: AppBarColor,
//              title: Align(
//                  alignment: Alignment.centerLeft,
//                  child: Container(
//                    decoration: myBoxDecoration(),
//                    height: 145,
//                    width: 275,
//                    child: Image.asset('assets/pnclogo.png',
//                        fit: BoxFit.contain),
//                  ))),
//        ),
      body: Column(children: [
        Container(
            decoration: BoxDecoration(color: AppBarColor),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 110,
                  width: 360,
                  child:
                      Image.asset('assets/pnclogo1.png', fit: BoxFit.scaleDown),
                ))),
        Expanded(
            child: Stack(children: [
          _buildPetIcons(context),
          _buildInvisibleSettingsPageButton(context),
        ])),
      ]),
    );
  }

  Widget _buildInvisibleSettingsPageButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Visibility(
            visible: true,
            child: GestureDetector(
              onTap: () {
                print('tapped');
                Navigator.of(context).pushNamed('/settingsPage');
              },
              child: Container(
                child: Text('  '),
              ),
            )));
  }

  Widget _buildPetIcons(BuildContext context) {
    return Container(
        // new color
        decoration: BoxDecoration(color: Color(0xEF80D2F5)),
        child: FutureBuilder<String>(
            future: SharedPreferencesHelper.getLocationSetting(),
            initialData: 'vet',
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? _buildTappableButtons(snapshot.data, context)
                  : Container();
            }));
  }

  /**
   * Will this destory the old icons when the user comes back from the settings page?
   *
   */
  Widget _buildTappableButtons(String location, BuildContext context) {
    switch (location) {
      case 'vet':
        {
          print('building vet buttons');
          return _buildVetButtons(context);
        }
        break;
      case 'humaneSociety':
        {
          print('building humane society buttons');
          return _buildHumaneSocietyButtons(context);
        }
        break;
      default:
        {
          print('building default vet buttons');
          return _buildVetButtons(context);
        }
        break;
    }
  }

  /**
   * TODO need to add text above the buttons but columns are fucking impossible
   */
  Widget _buildVetButtons(BuildContext context) {
    // TODO we may not want a GridView because it's scrollable. May be fun for the users, though
    return Column(children: [
      Padding(padding: EdgeInsets.all(ScreenUtil.instance.setWidth(50.0))),

      // text above pet buttons
      Text('What type of best friend do you have?',
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
      Text('(tap your pet below)',
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(42.0),
              fontFamily: 'Arial',
              color: Colors.white)),

      // pet buttons
      Expanded(
          child: Column(children: [
        GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(50.0),
                right: ScreenUtil.instance.setWidth(50.0),
                top: ScreenUtil.instance.setWidth(50.0)),
            mainAxisSpacing: ScreenUtil.instance.setWidth(10.0),
            crossAxisSpacing: ScreenUtil.instance.setWidth(10.0),
            shrinkWrap: true,
            children: pets.map((String url) {
              return GridTile(
                // doesn't have size
                child: PawsAnimatedButton(url),
              );
            }).toList()),
        // TODO refactor
        Container(
            child: Text(' Dog      Cat     Other',
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setSp(145.0),
                    fontFamily: 'Marydale',
                    fontWeight: FontWeight.w700,
                    color: Colors.white)))
      ])),
    ]);
  }

  /**
   * TODO need to add text above the buttons but columns are fucking impossible
   */
  Widget _buildHumaneSocietyButtons(BuildContext context) {
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
      Text('(tap your pet below)',
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(42.0),
              fontFamily: 'Arial',
              color: Colors.white)),

      // pet buttons
      Expanded(
          child: Column(children: [
        GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(50.0),
                right: ScreenUtil.instance.setWidth(50.0),
                top: ScreenUtil.instance.setWidth(50.0)),
            mainAxisSpacing: ScreenUtil.instance.setWidth(10.0),
            crossAxisSpacing: ScreenUtil.instance.setWidth(10.0),
            shrinkWrap: true,
            children: humanebuttons.map((String url) {
              return GridTile(
                // doesn't have size
                child: PawsAnimatedButton(url),
              );
            }).toList()),
        // TODO refactor
        Container(
            child: Text(' Dog      Cat     Other',
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setSp(145.0),
                    fontFamily: 'Marydale',
                    fontWeight: FontWeight.w700,
                    color: Colors.white)))
      ])),
    ]);
  }
}
// TODO do I need to make the buttons stateful?
//class MainTappableButtons extends StatefulWidget {
//  MainTappableButtons({
//    Key key,
//    this.locations,
//  }): super(key: key);
//  final List<String> locations;
//
//  @override
//  _MainTappableButtonsState createState() => new _MainTappableButtonsState();
//}
//
//class _MainTappableButtonsState extends State<MainTappableButtons> {
//  @override
//  void initState(){
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _getContent();
//  }
//}

// for debugging sometimes
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
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
