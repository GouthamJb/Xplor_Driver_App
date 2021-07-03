import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '/Controllers/gps_controller.dart';

class LocationController extends GetxController {
  final isAppInactive = false.obs;
  final locationString = "No Available Data".obs;
 
  GpsController _gpsController = new GpsController();

  updateLocationString(location) {
    locationString.value = location;
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
        Get.defaultDialog(
            onConfirm: () =>
                getCloseDefaultDialog().then((value) => openAppSettings()),
            barrierDismissible: false,
            textCancel: "Exit App",
            textConfirm: "Go to App Settings",
            onCancel: () => exit(0),
            title: 'Alert!',
            middleText:
                'You have denied location permission for this app, To continue please go to app setting & enable location permission');
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
                'You have permanently denied location permission for this app, To continue please go to app setting & enable location permission');
      } else if (result == PermissionStatus.granted) {
        Get.back(closeOverlays: true);
        _gpsController.getGpsStatus();
      }
    } else if (status == PermissionStatus.granted) {
      _gpsController.getGpsStatus();
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
}
