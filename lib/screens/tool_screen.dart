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

  bool online = true;

  @override
  void initState() {
    super.initState();

    getLogin();

    _handShake();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _handShake();
    });

    _apiCall();
    // Create a timer to call the function every second
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _apiCall();
    });
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
  List<String> toolAction = ['in', 'in', 'in', 'in', 'in'];
  String error = '';

  late Map<String, dynamic> fetchedData = {};

  _apiCall() async {
    try {
      final data = await APIService().fetch();
      // print(data['tools_detail']['action']);
      setState(() {
        fetchedData = data;
        error = '';
      });
    } catch (e) {
      setState(() {
        error = 'Failed to fetch symptoms: $e';
      });
    }
    // print(fetchedData);
    // print(fetchedData['data']['tools_detail'][0]['action']);
    // print(fetchedData['data']['tools_detail'][0]['get_tool_id']);

    int act =
        int.parse(fetchedData['data']['tools_detail'][0]['get_tool_id']) - 1;
    setState(() {
      // toolsStatus[0] = !toolsStatus[0];
      toolAction[act] = fetchedData['data']['tools_detail'][0]['action'];
    });
  }

  late Map<String, dynamic> handShakeData = {};

  _handShake() async{
    try{
      final data = await APIService().handShake();

      setState(() {
        handShakeData = data;
        online = handShakeData['status'];
      });
    }
    catch (e) {
      setState(() {
        error = 'Failed to fetch symptoms: $e';
      });
    }


  }

  _signoutHandle() async {
    await PreferencesManager.setLoggedIn(false);
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.black,
          primaryContainer: Color(0xFF002984),
          secondary: Color(0xFFD32F2F),
          secondaryContainer: Color(0xFF9A0007),
          surface: Color(0xFFDEE2E6),
          background: Color(0xFFF8F9FA),
          error: Color(0xFF96031A),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
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
              const SizedBox(
                height: 150,
                child: DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: Colors.white10,
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text('Divyansh', style: TextStyle(fontSize: 22)),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: Divider(color: Colors.white, thickness: 0.1, ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.1,color: Colors.white))),
                  child: GestureDetector(
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
                Container(
                  decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.4,color: Colors.white), left: BorderSide(width: 0.4,color: Colors.white),),),
                  child: GestureDetector(
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
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: Divider(color: Colors.white, thickness: 0.1, ),
            // ),
          ],
        ),
        // bottomNavigationBar: BottomAppBar(
        //   height: MediaQuery.of(context).size.height * 0.06,
        //   color: Colors.black,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // other buttons
        //       IconButton(
        //         icon: const Icon(Icons.menu_rounded,
        //             color: Colors.white), // Replace with "3 dost" icon
        //         onPressed: () => showModalBottomSheet(
        //           backgroundColor: Colors.black,
        //           context: context,
        //           builder: (context) => Padding(
        //             padding: const EdgeInsets.all(20),
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 const Text('Options',
        //                     style: TextStyle(color: Colors.white)),
        //                 const Divider(),
        //                 ListTile(
        //                   leading: const Icon(Icons.file_download, color: Colors.white), // Leading icon
        //                   title: const Text('Report',
        //                       style: TextStyle(color: Colors.white)),
        //
        //                   onTap: () {
        //                     // Handle report action
        //                     // Navigator.pop(context); // Close bottom sheet
        //                   },
        //                 ),
        //                 ListTile(
        //                   leading: const Icon(Icons.logout_rounded, color: Colors.white), // Leading icon
        //                   title: const Text('Sign Out',
        //                       style: TextStyle(color: Colors.white)),
        //                   onTap: () {
        //                     // Handle sign out action
        //                     // Navigator.pop(context); // Close bottom sheet
        //                     _signoutHandle();
        //                   },
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       online ? Row(
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 6),
        //             child: Text("Online", style: TextStyle(color: Colors.green, fontSize: 16),),
        //           ),
        //           Container(
        //             width: 10,
        //             height: 10,
        //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.green),
        //             // color: Colors.red,
        //           ),
        //
        //         ],
        //       ) : Row(
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 6),
        //             child: Text("Offline", style: TextStyle(color: Colors.red, fontSize: 16),),
        //           ),
        //           Container(
        //             width: 10,
        //             height: 10,
        //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
        //             // color: Colors.red,
        //           ),
        //
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
