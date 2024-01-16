import 'dart:async';

import 'package:component/dataStorage/preference_manager.dart';
import 'package:component/screens/login_page.dart';
import 'package:component/services/post_api_service.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}




class _ToolsScreenState extends State<ToolsScreen> {
  Timer? _timer;
  bool? loggedIn;

  @override
  void initState() {
    super.initState();

    getLogin();

    _apiCall();

    // Create a timer to call the function every second
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _apiCall();
    });

  }

  getLogin() async{
    bool val = await PreferencesManager.getLoggedIn();
    if(!val){
      _navigate();
    }
  }
  _navigate(){
    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) =>const LoginPage(),),);
  }



  List<bool> toolsStatus = [true, true, true, true, true];
  List<String> toolAction = ['in', 'in', 'in', 'in', 'in'];
  String error = '';

  late Map<String, dynamic> fetchedData = {};


  _apiCall() async{
    try {
      final data = await APIService().fetch();
      // print(data['tools_detail']['action']);
      setState(() {
        fetchedData = data;
        // callMsg(fetchedData.toString());
        error = '';
      });
    } catch (e) {
      setState(() {
        // callMsg("not called");
        error = 'Failed to fetch symptoms: $e';
      });
    }
    print(fetchedData);
    // print(fetchedData['data']['tools_detail'][0]['action']);
    // print(fetchedData['data']['tools_detail'][0]['get_tool_id']);

    int act = int.parse(fetchedData['data']['tools_detail'][0]['get_tool_id']) - 1;
    setState(() {
      // toolsStatus[0] = !toolsStatus[0];
      toolAction[act] = fetchedData['data']['tools_detail'][0]['action'];
    });

    print(toolAction);
  }

  // callMsg(String strMsg){
  //   ScaffoldMessenger.of(context).showSnackBar(
  //      SnackBar(
  //       duration: const Duration(seconds: 1),
  //       content: Text(strMsg),
  //     ),
  //   );
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle onTap event here
                  setState(() {
                    // toolsStatus[0] = !toolsStatus[0];
                  });
                  // _apiCall();
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: toolAction[0] == 'in'
                          ? Image.asset(
                        "assets/images/wrench_green.png",
                        fit: BoxFit.contain,
                      )
                          : Image.asset(
                        "assets/images/wrench_red.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle onTap event here
                  setState(() {
                    // toolsStatus[1] = !toolsStatus[1];
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      child: toolAction[1] == 'in'
                          ? Image.asset(
                        "assets/images/piler_green.png",
                        fit: BoxFit.contain,
                      )
                          : Image.asset(
                        "assets/images/piler_red.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle onTap event here
                  setState(() {
                    // toolsStatus[2] = !toolsStatus[2];
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(

                      child: toolAction[2] == 'in'
                          ? Image.asset(
                        "assets/images/wrench_green.png",
                        fit: BoxFit.contain,
                      )
                          : Image.asset(
                        "assets/images/wrench_red.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle onTap event here
                  setState(() {
                    // toolsStatus[3] = !toolsStatus[3];
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Container(

                      child: toolAction[3] == 'in'
                          ? Image.asset(
                        "assets/images/bolt_green.png",
                        fit: BoxFit.contain,
                      )
                          : Image.asset(
                        "assets/images/bolt_red.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle onTap event here
                  setState(() {
                    // toolsStatus[4] = !toolsStatus[4];
                  });
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(

                      child: toolAction[4] == 'in'
                          ? Image.asset(
                        "assets/images/wrench_green.png",
                        fit: BoxFit.contain,
                      )
                          : Image.asset(
                        "assets/images/wrench_red.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
