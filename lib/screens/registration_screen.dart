import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          print("Future Has Completed Now ---> ChatScreen");
          return ChatScreen();
        }
        if (snapshot.connectionState == ConnectionState.none) {
          print("ConnectionState = NONE");
          return _buildRegisterMainBody();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("ConnectionState = WAITING");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          print("Future Has Data");
        } else {
          print("Future Has No Data");
        }
        return snapshot.hasData
            ? CircularProgressIndicator()
            : _buildRegisterMainBody();
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
        _firebaseAuthFuture = _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        print("RegisterButton: $_firebaseAuthFuture ");
        setState(() {});
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

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
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
