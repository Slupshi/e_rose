import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_rose/models/address.dart';
import 'package:e_rose/models/city_polygon_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeoLocatorService {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //return Future.error('Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //return Future.error('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((lat2 - lat1) * p) / 2 +
    //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    // return 12742 * asin(sqrt(a));
  }

  static Future<LatLng?> getPosFromAddress(String address) async {
    try {
      final Dio dio = Dio();
      final res = await dio.get(
          "https://nominatim.openstreetmap.org/search?q=${address.replaceAll(' ', '+')}&format=json");
      final LatLng pos = LatLng(
        double.parse(res.data[0]["lat"]),
        double.parse(res.data[0]["lon"]),
      );
      return pos;
    } catch (ex) {
      return null;
    }
  }

  static Future<Address> getAddressFromPos(LatLng pos) async {
    final Dio dio = Dio();
    final res = await dio.get(
        "https://nominatim.openstreetmap.org/reverse?lat=${pos.latitude}&lon=${pos.longitude}&format=json&addressdetails=1");
    Address address = Address.fromJson(res.data["address"]);
    address = address.copyWith(displayAddress: res.data["display_name"]);
    return address;
  }

  static String? displayAddress(Address? address) => address != null
      ? "${address.houseNumber ?? ""} ${address.road ?? ""}${address.houseNumber != null && address.road != null ? "," : ""} ${address.postcode ?? ""} ${address.town ?? (address.city ?? "")}${address.postcode != null && address.town != null ? "," : ""} ${address.country ?? ""}"
      : null;

  static Future<CityPolygonModel?> getGeoJsonByCityName(
      String cityNameQuery) async {
    try {
      final Dio dio = Dio();
      final res = await dio.get(
          "https://nominatim.openstreetmap.org/search?city=$cityNameQuery&format=json&polygon_geojson=1");

      final cityData = (res.data as List).first;
      final coordinates = cityData["geojson"]["coordinates"][0];
      final cityName = cityData["display_name"].toString().split(",").first;
      final LatLng cityCenter = LatLng(
        double.parse(cityData["lat"]),
        double.parse(cityData["lon"]),
      );

      List<LatLng> positions = [];

      for (List coords in coordinates) {
        positions.add(
          LatLng(
            coords.last,
            coords.first,
          ),
        );
      }

      final CityPolygonModel model = CityPolygonModel(
        coordinates: positions,
        cityName: cityName,
        center: cityCenter,
      );
      return model;
    } catch (ex) {
      return null;
    }
  }
}
