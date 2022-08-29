import 'package:location/location.dart';

class LocationHelper {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    //servis açık mı
    bool _serviceEnabled;
    //izin var mı
    PermissionStatus _permissionGranted;
    //konum bilgisi
    LocationData _locationData;

    //Location için servis açık mı kontrolü
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    //konum izni kontrolü
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //izinler tamam ise
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
  }
}
