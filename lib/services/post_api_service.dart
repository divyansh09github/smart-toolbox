import 'dart:convert';

import 'package:component/dataStorage/preference_manager.dart';
import 'package:http/http.dart' as http;

class APIService{

  late Map<String, dynamic> albums = {};
  bool? error;

  Future<http.Response> login(String id, String pass) async {

    // String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // try {
      final response = await http.post(Uri.parse(
          "http://toolbox.techexposys.com/api/login?"
              "user=$id"
              "&password=$pass")
      );

      // if (response.statusCode == 200) {
      //   final albumData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
      //   error = false;
      //   print('abc: $albumData');
        return response;
    //   } else {
    //     // Handle error based on response status code
    //     throw Exception('API request failed with status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   // Handle network errors
    //   // throw Exception('API request failed: $e');
    //   return albums;
    // }

  }

  Future<http.Response> fetch() async {

    // String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String userId = await PreferencesManager.getUserId();
    String toolBoxId = await PreferencesManager.getToolBoxId();

    // try {
      final response = await http.get(Uri.parse(
          "http://toolbox.techexposys.com/api/tools_details?"
              "user_id=$userId"
              "&toolbox_id=$toolBoxId")
      );

      return response;
    //   if (response.statusCode == 200) {
    //     final albumData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
    //     error = false;
    //     // print(albumData);
    //     return albumData;
    //   } else {
    //     // Handle error based on response status code
    //     throw Exception('API request failed with status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   // Handle network errors
    //   // throw Exception('API request failed: $e');
    //   return albums;
    // }

  }

  Future<http.Response> handShake() async{
    String userId = await PreferencesManager.getUserId();
    String toolBoxId = await PreferencesManager.getToolBoxId();

    // try {
      final response = await http.get(Uri.parse(
          "http://toolbox.techexposys.com/api/onlinestatus"
      )
      );

      return response;

    //   if (response.statusCode == 200) {
    //     final albumData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
    //     error = false;
    //     print(albumData);
    //     return albumData;
    //   } else {
    //     // Handle error based on response status code
    //     throw Exception('API request failed with status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   // Handle network errors
    //   // throw Exception('API request failed: $e');
    //   return albums;
    // }

  }

}