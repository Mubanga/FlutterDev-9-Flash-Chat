import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "LOGIN_SCREEN";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  Future<AuthResult> _firebaseAuthFuture;
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
              // mainAxisAlignment: MainAxisAlignment.center,
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
                      hintText: "Enter Your Email"),
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
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Your Password"),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  buttonNameText: "Log In",
                  colour: Colors.lightBlueAccent,
                  onClick: () async {
                    /// Fire The Login Future For Our FutureBuilder
                    _firebaseAuthFuture = _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    _firebaseAuthFuture.then((_) {
                      print("Navigating Login -----> ChatScreen");
                      Navigator.pushReplacementNamed(context, ChatScreen.route);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
