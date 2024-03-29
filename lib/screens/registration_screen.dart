import 'dart:async';

import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/components/error_alert_dialog.dart';
import 'package:flash_chat/components/loading_screen.dart';

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
  ///
  ///  All Of This Can Be Deprecated If We Use The Package
  /// "modal_progress_hud 0.1.3" It Provides The Spinner Functionality
  /// An All You Need Do Is Wrap Your Scaffold In The Widget And Update
  /// A Boolean Flag Variable When You're Done.
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
            return LoadingScreen();

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
        return LoadingScreen();
      },
    );
  }

//  Center _buildRegisterIsLoading() {
//    return Center(
//      child: CircularProgressIndicator(),
//    );
//  }

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

      /// Necessary For Rebuilding Widget Tree So The FutureBuilder
      /// Can Display The LoadingScreen(CircularProgressIndicator)
      setState(() {});

      ///****N.B**** You Need To Wait For The Authentication Service To Complete
      /// And Then You May Proceed To Doing The Navigation *****N.B*****
      await _firebaseAuthFuture.then((_) {
        print("Navigating -----> ChatScreen().route");
        Navigator.pushReplacementNamed(context, ChatScreen.route);
      });
    } catch (e) {
      print("Exception ERROR: $e");
      ErrorAlert(context, e.toString(), WelcomeScreen.route);
    }
  }
}
