import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  static Future<Position?> getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        await Geolocator.requestPermission();
        return await Geolocator.getLastKnownPosition(
            forceAndroidLocationManager: true);
      default:
        Position pos = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        return pos;
    }
  }
}
