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
  Future<bool> _registrationComplete = Future<bool>.value(false);
  String _email;
  String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildFutureRegisterBody(),
    );
  }

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
//            Completer<bool> registrationCompleter = Completer();
//            registrationCompleter.complete(true);
//            print(
//                "registrationCompleter == ${registrationCompleter.isCompleted}");
//            _registrationComplete = registrationCompleter.future;
//            print("FRegCompleter == ${_registrationComplete}");
//            // return ChatScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

//          return snapshot.hasData
//              ? ChatScreen()
//              : Center(child: CircularProgressIndicator());
          //registrationCompleter.future;
          //  Navigator.of(context).pushReplacementNamed(ChatScreen.route);
          // Navigator.of(context).pushNamed(ChatScreen.route);
          //  return ChatScreen();
        } else if (snapshot.connectionState == ConnectionState.none) {
          print("ConnectionState = NONE, BuildingRegisterMainBody");
          return _buildRegisterMainBody();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          print("Attempting To Register User ConnectionState = WAITING");
//          return Center(
//            child: CircularProgressIndicator(),
//          );
        }
//        if (snapshot.hasData) {
//          print("Future Has Data");
//        } else {
//          print("Future Has No Data");
//        }
//        return snapshot.hasData
//            ? CircularProgressIndicator()
//            : _buildRegisterMainBody();
        if (snapshot.error != null) {
          print("Error");
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        return _buildResisterIsLoading();
      },
    );
  }

  Center _buildResisterIsLoading() {
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
      onClick: () async {
        // Fire And Forget And Let The FutureBuilder Do It's Thing
        try {
          _firebaseAuthFuture = _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          // _isLoading = await _registrationComplete;
          //        _registrationComplete.then((onValue) {
          //          _isLoading = onValue;
          //          print("_isLoading == $_isLoading");
          //        });
          print("RegisterButton: $_firebaseAuthFuture ");
          setState(() {
            //          if (_isLoading) {
            //            Navigator.of(context).pushNamed(ChatScreen.route);
            //          }
            //          _registrationComplete.then((isLoading) {
            //            print("RegIsLoading == $isLoading");
            //            if (isLoading == true) {
            //              Navigator.of(context).pushNamed(ChatScreen.route);
            //            }
            //  Navigator.of(context).pushNamed(ChatScreen.route);
          });
          final createdClient = await _firebaseAuthFuture;
          _firebaseAuthFuture.then((onValue) {
            print("-----> ChatScreen().route");
            Navigator.pushReplacementNamed(context, ChatScreen.route);
          });
        } catch (e) {
          print("Exception ERROR: $e");
          _ErrorAlert(context, e.toString(), WelcomeScreen.route);
          // TODO
        }
        // _firebaseAuthFuture.then(onValue)
//        if (createdClient != null) {
//          print("-----> ChatScreen().route");
//          Navigator.pushReplacementNamed(context, ChatScreen.route);
//        }
//        setState(() {
//          _isLoading = true;
//        });
        // _ackAlert(context);
        //    isRegisterComplete();
//                    final createdUser =
//                        await _auth.createUserWithEmailAndPassword(
//                            email: _email, password: _password);
//        print("Email : $_email Password: $_password");
        // _attemptLogin();
      },
    );
  }

//  void _attemptLogin() {
//    FutureBuilder(
//        future: _auth.createUserWithEmailAndPassword(
//            email: _email, password: _password),
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            print("Registering User Email: $_email Password: $_password");
//            Navigator.pushNamed(context, ChatScreen.route);
//          } else {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//        });
//  }

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
                Navigator.pushReplacementNamed(
                    context, fallbackNavigationRoute);
              },
            ),
          ],
        );
      },
    );
  }

//  Future _Spin(BuildContext context) {
//    return showDialog<void>(
//        context: context,
//        builder: (BuildContext context) {
//          return CircularProgressIndicator();
//        });
//  }

}
