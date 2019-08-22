import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flash_chat/screens/login_screen.dart';
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
  final _firestore = Firestore.instance;
  final _textMessageController = TextEditingController();
  String _message;
  FirebaseUser _LoggedInUser;

  void getCurrentUser() async {
    try {
      FirebaseUser currentUser = await _auth.currentUser();
      if (currentUser != null) {
        _LoggedInUser = currentUser;
//      About to run "flutter .create"
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
  void dispose() {
    _textMessageController.dispose();
    super.dispose();
  }

  void getMessages() async {
    final Messages = _firestore.collection("messages").snapshots();
    await for (var Message in Messages) {
      print("Message: $Message");
    }
  }

  StreamBuilder<QuerySnapshot> _buildMessageList() {
    return StreamBuilder(
      stream: _firestore.collection("messages").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<MessageBubble> textMessages = List<MessageBubble>();
          final messageList = snapshot.data.documents;
          for (var message in messageList) {
            final senderEmail = message.data['sender'];
            final senderMessage = message.data['text'];
            bool isMyMessage = false;
            if (_LoggedInUser.email == senderEmail) {
              isMyMessage = true;
            }
            final textMessage = MessageBubble(
              sender: senderEmail,
              message: senderMessage,
              isMe: isMyMessage,
            );
            textMessages.add(textMessage);
          }
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListView(
                children: textMessages,
              ),
            ),
          );
        }
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          /**
           * Sign Out
           */
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.route);

                Fluttertoast.showToast(
                    msg: "Logging Out : ${_LoggedInUser.email}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0);
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
            /**
             * Build Sent Messages
             */
            _buildMessageList(),
            /**
             * Type message here
             */
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textMessageController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      /// Adds Message To Firebase Collection
                      _firestore.collection('messages').add({
                        'text': _message,
                        'sender': _LoggedInUser.email.toString(),
                      });
                      _textMessageController.clear();
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
