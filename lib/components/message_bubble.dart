import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;

  MessageBubble({this.sender, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Text(
                  "$message",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
