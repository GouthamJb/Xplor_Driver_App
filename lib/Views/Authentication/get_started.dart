import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:xplor_driver_app/Controllers/location_controller.dart';
import 'sign_in.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with WidgetsBindingObserver {
  LocationController _locationController = new LocationController();
  @override
  void initState() {
    _locationController.checKLocationPermission();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //when page is detached or resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.paused) {
      _locationController.setAppInactive();
    }
    if ((_locationController.isAppInactive.value) &&
        (state == AppLifecycleState.resumed)) {
      print("From Background");
      _locationController.checKLocationPermission();
      _locationController.setAppActive();
    }
    super.didChangeAppLifecycleState(state);
  }

  //when pages is disposed
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Image.asset(
          'assets/backgrounds/get_started_bg.jpeg',
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
