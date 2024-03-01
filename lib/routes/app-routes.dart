import 'package:component/screens/login_page.dart';
import 'package:component/screens/tool_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {


  static const String compScreen = 'Comp';
  static const String toolScreen = 'tool_screen';
  static const String loginScreen = 'login_page';


  static Map<String, WidgetBuilder> routes = {

    // compScreen: (context) => Comp(),
    toolScreen: (context) => ToolsScreen(),
    loginScreen: (context) => LoginPage(),

  };
}