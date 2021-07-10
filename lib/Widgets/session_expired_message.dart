import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Views/Authentication/sign_in.dart';

class LoginErroMessage {
  static Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ERROR!',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Session Expied! Login again!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Get.offAll(() => SignInScreen(),
                    transition: Transition.rightToLeft);
              },
            ),
          ],
        );
      },
    );
  }
}
