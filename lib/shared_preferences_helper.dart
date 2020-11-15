import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static final String _locationSetting = 'locationSetting';

  static Future<String> getLocationSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_locationSetting) ?? 'vet';
  }

  static Future<bool> setLocationSetting(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_locationSetting, value);
  }
}

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final myString = prefs.getString(key) ?? '';
    if (myString == '') {
      return null;
    }
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
