import 'package:bloc_example/Utils/Location/location_service.dart';
import 'package:geocoding/geocoding.dart';

class LocationAddress {
  final LocationService service = LocationService();
  Future<String?> getLocationAddress() async {
    String? locationString;
    var p0 = await service.setupLocationService();
    double latitudeData = p0?.latitude ?? 0.0;
    double longitudeData = p0?.longitude ?? 0.0;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitudeData, longitudeData);
    String address =
        "${placemarks.first.name.toString()}, ${placemarks.first.subLocality.toString()}, ${placemarks.first.locality.toString()}";
    locationString = address;
    return locationString;
  }
}
