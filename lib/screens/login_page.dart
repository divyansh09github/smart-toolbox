// import 'package:email_validator/email_validator.dart';
import 'dart:convert';

import 'package:component/dataStorage/preference_manager.dart';
import 'package:component/screens/tool_screen.dart';
import 'package:component/services/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool? loggedIn;

  @override
  void initState(){
    super.initState();

    getLogin();

  }

  getLogin() async{
    bool val = await PreferencesManager.getLoggedIn();
    if(val){
      _navigateForward();
    }

  }

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Map<String, dynamic> loginData = {};

  _loginFunction() async {

    String id = idController.text;
    String password = passwordController.text;

    var response = await APIService().login(id, password);

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);

      if(response.statusCode == 401){
        print("401");
        var snackDemo = const SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          padding: EdgeInsets.all(10),
          content: Center(
            child: Text(
              "Invalid Username or Password",
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

    }
    else if (response.statusCode == 200){

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      // print("200");
      // print(body);
      setState(() {
        loginData = body;
      });
      // print("abc : $loginData");
      bool success = loginData['success'];
      String userId = loginData['user_id'];
      String userName = loginData['user_name'];
      String toolBoxId = loginData['toolbox_id'];
      String toolBoxName = loginData['toolbox_name'];
      List<Map<String, dynamic>> tools = [
        {"tool_id": loginData['tools_details'][0]['tool_id'], "tool_name": loginData['tools_details'][0]['tool_name']},
        {"tool_id": loginData['tools_details'][1]['tool_id'], "tool_name": loginData['tools_details'][1]['tool_name']},
        {"tool_id": loginData['tools_details'][2]['tool_id'], "tool_name": loginData['tools_details'][2]['tool_name']},
        {"tool_id": loginData['tools_details'][3]['tool_id'], "tool_name": loginData['tools_details'][3]['tool_name']},
        {"tool_id": loginData['tools_details'][4]['tool_id'], "tool_name": loginData['tools_details'][4]['tool_name']}
      ];
      // print(userid.runtimeType);
      if(success)
      {
        await PreferencesManager.setUserId(userId);
        await PreferencesManager.setUserName(userName);
        await PreferencesManager.setToolBoxId(toolBoxId);
        await PreferencesManager.setToolBoxName(toolBoxName);
        await PreferencesManager.saveTools(tools);
        await PreferencesManager.setLoggedIn(true);

        _navigateForward();
      }
      // else{
      //   await PreferencesManager.setLoggedIn(success);
      // }
      // await PreferencesManager.setLoggedIn(true);
      // _navigateForward();

    }

  }

  _navigateForward() async {
    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) =>const ToolsScreen(),),);
    // List<Map<String, dynamic>> savedTools = await PreferencesManager.getTools();
    // print("tooldetails11: ${savedTools}");
  }

  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            const Text(
              'Log in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:Colors.deepOrange ,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [

                  TextFormField(
                    // validator: (value) => EmailValidator.validate(value!)
                    //     ? null
                    //     : "Please enter a valid email",
                    controller: idController,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white), // Set input text color
                    decoration: InputDecoration(
                      prefixIconColor: Colors.white,
                      hintText: 'Id',
                      hintStyle: const TextStyle(color: Colors.white), // Set hint text color
                      // prefixIconColor: Colors.white,
                      prefixIcon: const Icon(Icons.perm_identity, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange), // Set border color when the field is not focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange), // Set border color when the field is focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your password';
                    //   }
                    //   return null;
                    // },
                    controller: passwordController,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white), // Set input text color
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password, color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white), // Set hint text color
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange), // Set border color when the field is not focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange), // Set border color when the field is focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // CheckboxListTile(
                  //   title: const Text("Remember me", style: TextStyle(color: Colors.white)),// Set the tile color to transparent
                  //   checkColor: Colors.white,
                  //   contentPadding: EdgeInsets.zero,
                  //   value: rememberValue,
                  //   activeColor: Theme.of(context).colorScheme.primary,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       rememberValue = newValue!;
                  //     });
                  //   },
                  //   controlAffinity: ListTileControlAffinity.leading,
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      _loginFunction();

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,color: Colors.deepOrange
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text('Not registered yet?', style: TextStyle(color: Colors.white)),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //     builder: (context) =>
                  //         //     const RegisterPage(title: 'Register UI'),
                  //         //   ),
                  //         // );
                  //       },
                  //       child: const Text('Create an account'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        ),
      ),

      bottomSheet: Container(
        // color: Colors.deepOrange,
        decoration: const BoxDecoration(
          color: Colors.black, // Your chosen color
          borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)), // Adjust radius
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Powered by", style: TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w400)),
                Text(" Tech Exponent System", style: TextStyle(fontSize: 15, color: Colors.deepOrange,fontWeight: FontWeight.w800)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}