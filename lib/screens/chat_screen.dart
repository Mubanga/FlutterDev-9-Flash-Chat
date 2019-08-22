import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

const TAG = "ChatScreen :";

class ChatScreen extends StatefulWidget {
  static const String route = "CHAT_SCREEN";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  /// If The Registration/Login Is Successful Then The FirebaseAuth Instance (_auth)
  /// Should Contain The Logged In User.
  final _auth = FirebaseAuth.instance;
  FirebaseUser _LoggedInUser;

  void getCurrentUser() async {
    try {
      FirebaseUser currentUser = await _auth.currentUser();
      if (currentUser != null) {
        _LoggedInUser = currentUser;

//        Widget _toast = Align(
//          alignment: FractionalOffset.bottomCenter,
//          child: Container(
//              width: 100.0,
//              height: 100.0,
//              color: Colors.grey.withOpacity(0.3),
//              child: Text("Email: ${_LoggedInUser.email}")),
//        );
//        ToastFuture toastFuture = showToastWidget(
//          _toast,
//          duration: Duration(seconds: 3),
//          onDismiss: () {
//            print(
//                "the toast dismiss"); // the method will be called on toast dismiss.
//          },
//        );

//        Align(
//          alignment: FractionalOffset.bottomCenter,
//          child: ,
//
        Fluttertoast.showToast(
            msg: "Email : ${_LoggedInUser.email}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (e) {
      //TODO: Also Display This Error In An AlertDialogue
      print("$TAG Error = $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
