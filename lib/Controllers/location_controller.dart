import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xplor_driver_app/Models/models/gps_model.dart';
import 'package:xplor_driver_app/Services/ApiServices/post_gps_service.dart';
import 'package:xplor_driver_app/Widgets/session_expired_message.dart';
import '/Controllers/gps_controller.dart';

class LocationController extends GetxController {
  final isAppInactive = false.obs;
  final locationString = "No Available Data".obs;

  GpsController _gpsController = new GpsController();

  GpsService _gpsService = new GpsService();

  updateLocationString(location) {
    locationString.value = location;
  }

  checKLocationPermission({isCurrentRunning = false}) async {
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
        if (!isCurrentRunning) {
          _gpsController.getGpsStatus();
        }
      }
    } else if (status == PermissionStatus.granted) {
      if (!isCurrentRunning) {
        _gpsController.getGpsStatus();
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

  updateGpsDetailToRemote(lat, long, context) async {
    Map body = {
      "vehicle_id": 3,
      "vehicle_latitude": lat,
      "vehicle_longitude": long,
      "is_active": true
    };
    GpsPost jsonResponse = await _gpsService.fetchFromRemote(body);
    if (jsonResponse.details.message == 'Token has Expired' ||
        jsonResponse.details.message == 'Token Invalid') {
      LoginErroMessage.showMyDialog(context);
      // Get.offAll(() => SignInScreen(),transition: Transition.rightToLeft);
    } else if (jsonResponse.details.message == 'Something went wrong!') {
      print("Something went wrong");
      Get.snackbar('Sorry', 'Something went wrong',
          duration: Duration(seconds: 5));
    } else if (jsonResponse.details.message ==
        'GPS value has been successfully updated!') {
      print(jsonResponse.details.message);
    }
  }

  @override
  void onInit() {
    checKLocationPermission();
    super.onInit();
  }
}
