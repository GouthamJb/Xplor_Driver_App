import 'dart:async';
import 'dart:io';

import 'package:background_location/background_location.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  BackgroundLocation _backgroundLocation = new BackgroundLocation();
  Timer _timer;
  bool _isTimerInitialized = false;
  final locatusStatus = "Location service is not enabled".obs;
  final isAppInactive = false.obs;
  getCurrentLocation() {
    _backgroundLocation.getCurrentLocation().then((location) => {
          print('This is current Location ' + location.toMap().toString()),
          locatusStatus.value = location.toMap().toString()
        });
  }

  onStartLocationServiceClick() async {
    try {
      await BackgroundLocation.startLocationService();
      locatusStatus.value = 'Location Service is starting....';
      print("Background Location Service is starting......");
      _timer = new Timer.periodic(Duration(seconds: 12), (Timer t) {
        _isTimerInitialized = true;
        getCurrentLocation();
      });
    } catch (e) {
      print(e);
    }
  }

  onStopLocationServiceClick() {
    print("Background Location Service is stopping.....");
    locatusStatus.value = 'Location service is not enabled';
    BackgroundLocation.stopLocationService();
    if (_isTimerInitialized) {
      _timer.cancel();
    }
  }

  checKLocationPermission() async {
    var status = await Permission.location.status;
    print("status:$status");
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      var result = await Permission.location.request();
      print("result:$result");
      if (result == PermissionStatus.denied) {
        print("Permission is denied");
      } else if (result == PermissionStatus.permanentlyDenied) {
        print("Permission is permanently denied");
        Get.defaultDialog(
            onConfirm: () =>
                getCloseDefaultDialog().then((value) => openAppSettings()),
            barrierDismissible: false,
            textCancel: "Exit App",
            textConfirm: "Go to App Settings",
            onCancel: () => exit(0),
            title: 'Alert!',
            middleText:
                'You have permanently disabled location permission for this app, To continue please go to app setting & enable location permission');
      }
    }
  }

  Future<void> getCloseDefaultDialog() async {
    Get.back(closeOverlays: true);
  }

  setAppActive() {
    isAppInactive.value = false;
  }

  setAppInactive() {
    isAppInactive.value = true;
  }

  @override
  void onInit() {
    checKLocationPermission();
    super.onInit();
  }

  @override
  void onClose() {
    if (_isTimerInitialized) {
      _timer.cancel();
    }
    BackgroundLocation.stopLocationService();
    super.onClose();
  }
}
