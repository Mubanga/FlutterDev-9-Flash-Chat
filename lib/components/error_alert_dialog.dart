import 'package:flutter/material.dart';

Future<void> ErrorAlert(
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
              /// pushReplacementNamed Pops The Most Recent Route Off Of The
              /// Navigation Stack And Then Pushes The New One On.

              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, fallbackNavigationRoute);
//              if (fallbackNavigationRoute != null &&
//                  fallbackNavigationRoute != "") {
//                Navigator.pushReplacementNamed(
//                    context, fallbackNavigationRoute);
//              } else if (fallbackNavigationRoute == " ") {
//                Navigator.pop(context);
//              }
            },
          ),
        ],
      );
    },
  );
}
