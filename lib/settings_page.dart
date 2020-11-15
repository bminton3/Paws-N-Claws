import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_vet_tv/download_helper.dart';
import 'shared_preferences_helper.dart';
import 'util.dart';

/**
 * TODO this is till buggy. According to logs, the home screen appears to be rendering multiple times.
 */
class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String locationType = pawsLocations[0];
  SharedPref sharedPref = SharedPref();
  DownloadHelper _downloadHelper = DownloadHelper();

//  DownloadHelper _downloadHelper = Util().downloadHelper;

  loadSharedPrefs() async {
    try {
      DownloadHelper user = DownloadHelper.fromJson(await sharedPref.read('downloadhelper'));
      Scaffold.of(context).showSnackBar(
          SnackBar(content: new Text("Loaded!"), duration: const Duration(milliseconds: 500)));
      setState(() {
        _downloadHelper = user;
      });
    } catch (Excepetion) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"), duration: const Duration(milliseconds: 500)));
    }
  }

  // What is going on here???
  @override
  void initState() {
    setState(() {
      SharedPreferencesHelper.getLocationSetting().then((result) {
        setState(() {
          // isn't this already a string??
          print(":: debug result >>>" + result.toString());
          locationType = result;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Color(0xEF80D2F5)),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      title: const Text('Vet\'s office'),
                      leading: Radio(
                        value: pawsLocations[0],
                        groupValue: locationType,
                        onChanged: (String value) async {
                          locationType = value;
                          // does this work???
                          await SharedPreferencesHelper.setLocationSetting(locationType);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      title: const Text('Humane Society'),
                      leading: Radio(
                        value: pawsLocations[1],
                        groupValue: locationType,
                        onChanged: (String value) async {
                          locationType = value;
                          // does this work???
                          await SharedPreferencesHelper.setLocationSetting(locationType);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    // WTF??
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Apply",
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    loadSharedPrefs();
                    _downloadHelper.downloadVideosFromFirebase();
                    setState(() {});
                  },
                  child: Text(
                    "Download Videos",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
