import 'package:latlong2/latlong.dart';

class CityPolygonModel {
  final List<LatLng> coordinates;
  final String? cityName;
  final LatLng center;
  CityPolygonModel({
    required this.coordinates,
    required this.cityName,
    required this.center,
  });
}
