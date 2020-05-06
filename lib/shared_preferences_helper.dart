import 'package:shared_preferences/shared_preferences.dart';

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