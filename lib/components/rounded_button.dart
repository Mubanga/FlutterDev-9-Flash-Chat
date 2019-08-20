import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonNameText;
  final Function onClick;
  final Color colour;

  RoundedButton(
      {@required this.buttonNameText,
      @required this.colour,
      @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onClick,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonNameText,
          ),
        ),
      ),
    );
  }
}
