import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService{

//   Future postTools(String action, int toolId) async{
//
//     final response = await http.post(
//         Uri.parse(
//             'http://toolbox.techexposys.com/api/tools_count?'
//             'toolbox_id=TES111'
//             '&get_tool_id=$toolId'
//             '&user_id=2'
//             '&tool_action=$action'
//         ),
//         headers: {"Content-Type": "application/json"}
//     );
//
//     // print(response.body);
//
//     print(action);
//     print(toolId);
//
// }

  late Map<String, dynamic> albums = {};
  bool? error;

  Future<Map<String, dynamic>> fetch() async {

    // String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    try {
      final response = await http.get(Uri.parse(
          "http://toolbox.techexposys.com/api/tools_details?"
              "user_id=2"
              "&toolbox_id=TES111")
      );

      if (response.statusCode == 200) {
        final albumData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
        error = false;
        // print(albumData);
        return albumData;
      } else {
        // Handle error based on response status code
        throw Exception('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      // throw Exception('API request failed: $e');
      return albums;
    }

  }

  Future<Map<String, dynamic>> handShake() async{

    try {
      final response = await http.get(Uri.parse(
          "http://toolbox.techexposys.com/api/handshake?"
              "user_id=2"
              "&toolbox_id=TES111")
      );

      if (response.statusCode == 200) {
        final albumData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
        error = false;
        // print(albumData);
        return albumData;
      } else {
        // Handle error based on response status code
        throw Exception('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      // throw Exception('API request failed: $e');
      return albums;
    }

  }

}