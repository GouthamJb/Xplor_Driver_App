import 'dart:async';

import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  final isAppInactive = false.obs;
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
                'You have permanently denied location permission for this app, To continue please go to app setting & enable location permission');
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
}
