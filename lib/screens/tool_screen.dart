import 'dart:async';
import 'dart:convert';

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

  bool online = false;
  String? onOfText;

  @override
  void initState() {
    super.initState();

    getLogin();

    _handShake();
    _timer = Timer.periodic(const Duration(seconds: 90), (timer) {
      _handShake();
    });

    _apiCall();
    // Create a timer to call the function every second
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _apiCall();
    });

    _toolsDetails();
  }

  late List<Map<String, dynamic>> nameId;
  late String toolboxId;
  late String userName;
  late String userId;
  _toolsDetails() async{

    List<Map<String, dynamic>> savedTools = await PreferencesManager.getTools();
    String toolboxid = await PreferencesManager.getToolBoxId();
    String usernm = await PreferencesManager.getUserName();
    String userid = await PreferencesManager.getUserId();
    setState(() {
      nameId = savedTools;
      toolboxId = toolboxid;
      userName = usernm;
      userId = userid;
    });
    print("tooldetails123: ${nameId[0]['tool_name']}");
  }


  getLogin() async {
    bool val = await PreferencesManager.getLoggedIn();
    if (!val) {
      _navigate();
    }
  }

  _navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  List<bool> toolsStatus = [true, true, true, true, true];
  List<bool> toolAction = [true, true, true, true, true];
  String error = '';

  late Map<String, dynamic> fetchedData = {};

  _apiCall() async {

    var response = await APIService().fetch();

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
    }
      else if (response.statusCode == 200) {

        final body = jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          fetchedData = body;
        });
        // print(fetchedData);
        int act = fetchedData['data']['tools_detail'][0]['get_tool_id'] - 1;
        setState(() {
          // toolsStatus[0] = !toolsStatus[0];
          toolAction[act] = fetchedData['data']['tools_detail'][0]['action'];
        });

      }

    }

    // try {
    //   final data = await APIService().fetch();
    //   // print(data['tools_detail']['action']);
    //   setState(() {
    //     fetchedData = data;
    //     error = '';
    //   });
    // } catch (e) {
    //   if(mounted){
    //     setState(() {
    //       error = 'Failed to fetch symptoms: $e';
    //     });
    //   }
    //
    // }
    // print(fetchedData);
    // print(fetchedData['data']['tools_detail'][0]['action']);
    // print(fetchedData['data']['tools_detail'][0]['get_tool_id']);

    // int act =
    //     int.parse(fetchedData['data']['tools_detail'][0]['get_tool_id']) - 1;
    // setState(() {
    //   // toolsStatus[0] = !toolsStatus[0];
    //   toolAction[act] = fetchedData['data']['tools_detail'][0]['action'];
    // });
  // }

  late Map<String, dynamic> handShakeData = {};

  _handShake() async{
    // try{
    var response = await APIService().handShake();

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;

      var snackDemo = SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        padding: EdgeInsets.all(10),
        content: Center(
          child: Text(
            "${response.statusCode}",
            style: TextStyle(color: Color(0xFF972633)),
          ),
        ),
        backgroundColor: Color(0xFFfedbd5),
        // Or any other desired background color
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 4),
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(
                15), // Customize corner radius as needed
          ),
        ),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackDemo);

    }
    else if (response.statusCode == 200) {

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        handShakeData = body;
        online = body['status'];
      });

    }
    //   print(data);
    //   setState(() {
    //     handShakeData = data;
    //     online = bool.parse(data['status']);
    //     // online = on;
    //   });
    // // }
    // // catch (e) {
    // //   setState(() {
    // //     error = 'Failed to fetch symptoms: $e';
    // //   });
    // // }
    // // if(online == true){
    // //   onOfText = "Online";
    // // }
    // // else{
    // //   onOfText = "Offline";
    // // }
    //
    // // setState(() {
    // //   online = true;
    // // });
    // print(online.runtimeType);

  }

  _signoutHandle() async {
    await PreferencesManager.setLoggedIn(false);
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: online ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  "Online",
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green),
                // color: Colors.red,
              ),
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  "Offline",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red),
                // color: Colors.red,
              ),
            ],
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),

        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.66,
          backgroundColor: Colors.white70,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 150,
                child: DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: Colors.white10,
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("$userName $userId", style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.download,
              //   ),
              //   title: const Text('Report'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),

              ExpansionTile(
                leading: const Icon(Icons.download),
                title: const Text('Report'),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('User Details'),
                      onTap: () {
                        // Handle user details action
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                    child: ListTile(
                      leading: const Icon(Icons.build),
                      title: const Text('Tool Details'),
                      onTap: () {
                        // Handle tool details action
                      },
                    ),
                  ),
                ],
              ),





              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                ),
                title: const Text('Sign Out'),
                onTap: () {
                  // Navigator.pop(context);
                  _signoutHandle();
                },
              ),

            ],
          ),

        ),

        backgroundColor: Colors.black,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: toolAction[2]
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
                           RotatedBox(
                            // angle: 90,
                            quarterTurns: 1,
                            child: Text(
                              "${nameId[0]['tool_name']} - ${nameId[0]['tool_id']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                                height: MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Container(
                                    child: toolAction[1]
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
                          RotatedBox(
                            // angle: 90,
                            quarterTurns: 1,
                            child: Text(
                              "${nameId[1]['tool_name']} - ${nameId[1]['tool_id']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  child: toolAction[0]
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
                          RotatedBox(
                            // angle: 90,
                            quarterTurns: 1,
                            child: Text(
                              "${nameId[2]['tool_name']} - ${nameId[2]['tool_id']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: toolAction[4]
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
                          RotatedBox(
                            // angle: 90,
                            quarterTurns: 1,
                            child: Text(
                              "${nameId[3]['tool_name']} - ${nameId[3]['tool_id']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: toolAction[3]
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
                          RotatedBox(
                            // angle: 90,
                            quarterTurns: 1,
                            child: Text(
                              "${nameId[4]['tool_name']} - ${nameId[4]['tool_id']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    // angle: 90,
                    quarterTurns: 1,
                    child: Text(
                      "$toolboxId",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),

      );
  }
}
