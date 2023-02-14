import 'package:location/location.dart';

class LocationModel {
  static final Location location = Location();

  //getLocation method and check location

  static Future<LocationData?> getLocationMethod() async {
    var serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return location.getLocation();
  }
}
