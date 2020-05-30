import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'shared_preferences_helper.dart';
import 'util.dart';

/**
 * TODO this is till buggy. The home screen appears to be rendering multiple times.
 */
class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String locationType = pawsLocations[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Color(0xEF80D2F5)),
          child: Center(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    title: const Text('Vet\'s office'),
                    leading: Radio(
                      value: pawsLocations[0],
                      groupValue: locationType,
                      onChanged: (String value) async {
                        locationType = value;
                        await SharedPreferencesHelper.setLocationSetting(
                            locationType);
                        setState(() {});
                      },
                    ),
                ),),
                Align(
                  alignment: Alignment.center,
                  child: ListTile(
                      title: const Text('Humane Society'),
                      leading: Radio(
                        value: pawsLocations[1],
                        groupValue: locationType,
                        onChanged: (String value) async {
                          locationType = value;
                          await SharedPreferencesHelper.setLocationSetting(
                              locationType);
                          setState(() {});
                        },
                      ),
                    ),),
                FlatButton(
                  onPressed: () {
                    setState(() {});

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Apply",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      SharedPreferencesHelper.getLocationSetting().then((result) {
        setState(() {
          print(":: debug result >>>" + result.toString());
          locationType = result;
        });
      });
    });
    super.initState();
  }
}
