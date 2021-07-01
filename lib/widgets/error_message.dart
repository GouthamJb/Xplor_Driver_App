import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ErroMessage {
  static Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert!',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You have permanently disabled location permission for this app, To continue please go to app setting & enable location permission'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
