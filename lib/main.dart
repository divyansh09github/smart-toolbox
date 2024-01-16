import 'package:component/core/utils/navigator_service.dart';
import 'package:component/dataStorage/preference_manager.dart';
import 'package:component/routes/app-routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   // @override
//   // Widget build(BuildContext context) {
//
//     //
//     // return MaterialApp(
//     //   title: 'Flutter Demo',
//     //   debugShowCheckedModeBanner: false,
//     //   navigatorKey: NavigatorService.navigatorKey,
//     //   // initialRoute: initialRoute,
//     //   routes: AppRoutes.routes,
//     //   theme: ThemeData(
//     //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//     //     useMaterial3: true,
//     //   ),
//     //   // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     // );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  bool? loggedIn;

  @override


  void initState() {
    super.initState();

    // // 1. Set landscape orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    // 2. Check login status asynchronously
    _loginCheck();
  }

  Future<void> _loginCheck() async {
    loggedIn = await PreferencesManager.getLoggedIn();
    setState(() {}); // Trigger a rebuild to update the initialRoute
  }

  @override
  Widget build(BuildContext context) {

    // String initialRoute = loggedIn == true ? AppRoutes.toolScreen : AppRoutes.loginScreen;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorService.navigatorKey,
      initialRoute: AppRoutes.toolScreen,
      routes: AppRoutes.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
