import 'dart:convert';

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

  static Future<String> getUserId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('getUserId') ?? '0';
  }


  static Future<void> setUserId(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('getUserId', value);
  }

  static Future<String> getUserName() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('getUserName') ?? '';
  }


  static Future<void> setUserName(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('getUserName', value);
  }

  static Future<String> getToolBoxId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('getToolBoxId') ?? '0';
  }


  static Future<void> setToolBoxId(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('getToolBoxId', value);
  }

  static Future<String> getToolBoxName() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('getToolBoxName') ?? '';
  }


  static Future<void> setToolBoxName(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('getToolBoxName', value);
  }

  static Future<void> saveTools(List<Map<String, dynamic>> tools) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String toolsJson = jsonEncode(tools);
    await prefs.setString('tools', toolsJson);
  }

  static Future<List<Map<String, dynamic>>> getTools() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? toolsJson = prefs.getString('tools');
    if (toolsJson != null) {
    return List<Map<String, dynamic>>.from(jsonDecode(toolsJson));
  }
    return [];
  }

}