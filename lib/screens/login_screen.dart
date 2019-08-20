import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "LOGIN_SCREEN";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter Your Email"),
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
              onClick: () {},
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.lightBlueAccent,
//                borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//                    //Implement login functionality.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Log In',
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
