import 'dart:async';
import 'dart:io';

import 'package:background_location/background_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xplor_driver_app/Controllers/gps_controller.dart';
import 'package:xplor_driver_app/Controllers/location_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  BackgroundLocation _backgroundLocation = new BackgroundLocation();
  GpsController _gpsController = new GpsController();
  Timer _timer;
  bool locationServiceStatus = false;
  bool _isTimerInitialized = false;
  int noOfClick = 0;
  LocationController _locationController = Get.put(LocationController());
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

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
    if (state == AppLifecycleState.detached) {
      onStopLocationServiceClick();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
    print('App is closing........');
    if (_isTimerInitialized) {
      _timer.cancel();
    }
    noOfClick = 0;
    locationServiceStatus = false;
    BackgroundLocation.stopLocationService();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> _onwillPopScpoe() async {
    Get.defaultDialog(
        textConfirm: 'Exit App',
        onConfirm: () => exit(0),
        onCancel: () => Get.back(closeOverlays: true),
        title: 'Do you really want to exit?',
        middleText: 'Exiting the application will stop fetching location');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WillPopScope(
        onWillPop: _onwillPopScpoe,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Background Location Service'),
          ),
          body: Center(
            child: ListView(
              children: <Widget>[
                Obx(() =>
                    locationData(_locationController.locationString.value)),
                ElevatedButton(
                    onPressed: () {
                      onStartLocationServiceClick();
                    },
                    child: Text(noOfClick != 0
                        ? locationServiceStatus
                            ? 'Fetching Location...'
                            : 'Start Location Service'
                        : 'Get Ready!')),
                ElevatedButton(
                    onPressed: () {
                      onStopLocationServiceClick();
                    },
                    child: Text('Stop Location Service')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  onStartLocationServiceClick() async {
    try {
      if (!locationServiceStatus) {
        await BackgroundLocation.setAndroidNotification(
          title: "Xplor Driver App",
          message: "Currently fetching location",
          icon: "@mipmap/ic_launcher",
        );
        setState(() {
          noOfClick++;
          print(noOfClick);
        });

        await BackgroundLocation.startLocationService();
        if (noOfClick == 1) {
          BackgroundLocation.stopLocationService();
        } else {
          print("Background Location Service is starting......");
          setState(() {
            locationServiceStatus = true;
            _timer = new Timer.periodic(Duration(seconds: 12), (Timer t) {
              _isTimerInitialized = true;
              getCurrentLocation();
            });
          });
        }
      } else {
        print("Background Location Service is already runinng.......");
      }
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    await _locationController.checKLocationPermission();
    _backgroundLocation.getCurrentLocation().then((location) => {
          print('This is current Location ' + location.toMap().toString()),
          _locationController.updateLocationString(location.toMap().toString())
        });
  }

  onStopLocationServiceClick() {
    print("Background Location Service is stopping.....");
    setState(() {
      noOfClick = 0;
      locationServiceStatus = false;
      BackgroundLocation.stopLocationService();
      _locationController.updateLocationString('No Available Data');
      if (_isTimerInitialized) {
        _timer.cancel();
      }
    });
  }
}
