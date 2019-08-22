import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  MessageBubble(
      {@required this.sender, @required this.message, @required this.isMe});

  @override
  Widget build(BuildContext context) {
    final notMyMessageRadius = BorderRadius.only(
        topLeft: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0));

    final myMessageRadius = BorderRadius.only(
        topRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: isMe ? Alignment.centerLeft : Alignment.bottomRight,
            child: Text(
              sender,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: isMe ? Alignment.centerLeft : Alignment.bottomRight,
            child: Material(
              elevation: 5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.amber,
              borderRadius: isMe ? myMessageRadius : notMyMessageRadius,
              child: Container(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    "$message",
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
