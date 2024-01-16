import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager{

  static Future<bool> getLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('getLoggedIn') ?? false;
  }


  static Future<void> setLoggedIn(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('getLoggedIn', value);
  }

}