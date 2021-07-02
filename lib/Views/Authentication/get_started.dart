import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'sign_in.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Image.asset(
          'assets/backgrounds/get_started_bg.png',
          fit: BoxFit.cover,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(33, 20, 33, 20),
        child: ElevatedButton(
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Get.to(() => SignInScreen(), transition: Transition.cupertino);
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.fromLTRB(0, 8, 0, 8.8)),
            foregroundColor:
                MaterialStateProperty.all<Color>(Color(0x88002c3e)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff002c3e)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
