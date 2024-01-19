// import 'package:email_validator/email_validator.dart';
import 'package:component/dataStorage/preference_manager.dart';
import 'package:component/screens/tool_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // bool? loggedIn;
  //
  // @override
  // void initState(){
  //   super.initState();
  //
  //   getLogin();
  //
  // }
  //
  // getLogin() async{
  //   bool val = await PreferencesManager.getLoggedIn();
  //   if(val){
  //     _navigateForward();
  //   }
  //
  // }

  _loginFunction() async {

    await PreferencesManager.setLoggedIn(true);
    _navigateForward();

  }

  _navigateForward(){
    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) =>const ToolsScreen(),),);
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
                color:Color(0xFF6F43BF) ,
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
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white), // Set input text color
                    decoration: InputDecoration(
                      prefixIconColor: Colors.white,
                      hintText: 'Id',
                      hintStyle: const TextStyle(color: Colors.white), // Set hint text color
                      // prefixIconColor: Colors.white,
                      prefixIcon: const Icon(Icons.perm_identity, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF6F43BF)), // Set border color when the field is not focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF6F43BF)), // Set border color when the field is focused
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
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white), // Set input text color
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password, color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white), // Set hint text color
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF6F43BF)), // Set border color when the field is not focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF6F43BF)), // Set border color when the field is focused
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
                        fontSize: 16
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