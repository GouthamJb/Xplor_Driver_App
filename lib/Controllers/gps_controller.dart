import 'package:location/location.dart';

class GpsController {
  GpsController();
  getGpsStatus() async {
    Location location = new Location();

    var _serviceEnabled = await location.serviceEnabled();
    while(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print(_serviceEnabled);
    }
  }
}
