import 'dart:async';

import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "REGISTRATION_SCREEN";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  Future<AuthResult> _firebaseAuthFuture;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildFutureRegisterBody(),
    );
  }

  /// The FutureBuilder Forms The Basis/Body Of The Entire Screen (Scaffold)
  /// This Is Done So When The User Attempts To Register We Can Replace The
  /// Main RegistrationScreen (_buildRegisterMainBody()) With A Loading Spinner
  /// (_buildRegisterIsLoading())
  FutureBuilder<AuthResult> _buildFutureRegisterBody() {
    return FutureBuilder(
      future: _firebaseAuthFuture,
      builder: (BuildContext context, AsyncSnapshot<AuthResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print("Future Has Completed Now ---> ChatScreen");

            if (snapshot.error != null) {
              print("Error");
              return Text(snapshot.error.toString());
            }
          } else {
            return _buildRegisterIsLoading();

            /// Strictly Speaking You Can Do Navigation To Another Screen Here
            /// By Just Returning The Entire Screen, However Best Practices State
            /// You Should Always Use The Navigator To Move Between Screens
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          print("ConnectionState = NONE, BuildingRegisterMainBody");
          return _buildRegisterMainBody();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          print("Attempting To Register User ConnectionState = WAITING");
        }
        if (snapshot.error != null) {
          print("Error");
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        return _buildRegisterIsLoading();
      },
    );
  }

  Center _buildRegisterIsLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Padding _buildRegisterMainBody() {
    return Padding(
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
              /**
               * Register Button
               */
              _buildRegisterButton()
            ],
          ),
        ),
      ),
    );
  }

  RoundedButton _buildRegisterButton() {
    return RoundedButton(
      buttonNameText: "Register",
      colour: Colors.blueAccent,
      onClick: _RegisterUser,
    );
  }

  void _RegisterUser() async {
    try {
      // Fire And Forget And Let The FutureBuilder Do It's Thing
      _firebaseAuthFuture = _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      print("RegisterButton: $_firebaseAuthFuture ");
      setState(() {});
      final createdClient = await _firebaseAuthFuture;
      _firebaseAuthFuture.then((onValue) {
        print("Navigating -----> ChatScreen().route");
        Navigator.pushReplacementNamed(context, ChatScreen.route);
      });
    } catch (e) {
      print("Exception ERROR: $e");
      _ErrorAlert(context, e.toString(), WelcomeScreen.route);
    }
  }

  Future<void> _ErrorAlert(
      BuildContext context, String e, String fallbackNavigationRoute) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(e),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                //  Navigator.of(context).pop();
                /// pushReplacementNamed Pops The Most Recent Route Off Of The
                /// Navigation Stack And Then Pushes The New One On.
                Navigator.pushReplacementNamed(
                    context, fallbackNavigationRoute);
              },
            ),
          ],
        );
      },
    );
  }
}
