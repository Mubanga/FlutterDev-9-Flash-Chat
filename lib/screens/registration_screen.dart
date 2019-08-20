import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "REGISTRATION_SCREEN";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: "logo_transition",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                /**
                 * Email TextField(EditText)
                 */
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter Your Email",
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                /**
                 * Password TextField(EditText)
                 */
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Your Password"),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  buttonNameText: "Register",
                  colour: Colors.blueAccent,
                  onClick: () {
                    print("Email : $_email Password: $_password");
                  },
                )
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.blueAccent,
//                borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//                    //Implement registration functionality.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Register',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ),
//              ),
//            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
