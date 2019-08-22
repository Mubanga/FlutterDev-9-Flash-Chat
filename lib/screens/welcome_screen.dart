import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "WELCOME_SCREEN";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    /// In Using Explicit Animations (Animations Not Done With A Hero Widget)
    /// We Need To Create An Animation Controller So That It Can Be In Charge
    /// Of Various Aspects Of The Animation We Want To Be Shown.
    /// Firstly:  #1 Create The AnimationController ***N.B Always Set The "duration:" And "vsync:" properties
    /// Secondly: #2 Instruct The AnimationController To Advance.
    /// Thirdly:  #3 (Optional) Add A Listner To The Animation Controller To See The
    /// State Of The AnimationController.
    ///
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    /// For The Animation Object You Specify The TYPE Of Animation You Want
    /// Two Required Parameters Are Necessary. Firstly "parent" AnimationController,
    /// "curve:" E.g. Curves.linear,Curves.bounceIn,Curves.decelerate etc.
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

    _animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(_animationController);

    /// This Essentially Starts The Animation
    _animationController.forward();

    _animationController.addListener(() {
      setState(() {});
      print("Animation Status: ${_animation.value} ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: "logo_transition",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: (_animationController.value) * 100.0, //60.0,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            /**
             * Login Button
             */
            RoundedButton(
              buttonNameText: "Login",
              colour: Colors.lightBlueAccent,
              onClick: () {
                Navigator.pushNamed(context, LoginScreen.route);
              },
            ),
            /**
             *  Register Button
             */
            RoundedButton(
              buttonNameText: "Register",
              colour: Colors.blueAccent,
              onClick: () {
                Navigator.pushNamed(context, RegistrationScreen.route);
              },
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                elevation: 5.0,
//                color: Colors.lightBlueAccent,
//                borderRadius: BorderRadius.circular(30.0),
//                child: MaterialButton(
//                  onPressed: () {
//                    Navigator.pushNamed(context, LoginScreen.route);
//                    //Go to login screen.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Log In',
//                  ),
//                ),
//              ),
//            ),

//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.blueAccent,
//                borderRadius: BorderRadius.circular(30.0),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//                    //Go to registration screen.
//                    Navigator.pushNamed(context, RegistrationScreen.route);
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Register',
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
