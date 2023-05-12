import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/models/hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HeroCardMapWidget extends StatelessWidget {
  final HeroModel selectedHero;
  final Position? userPosition;
  final MapController mapController;
  final BoxConstraints constraints;
  const HeroCardMapWidget({
    super.key,
    required this.mapController,
    required this.selectedHero,
    required this.userPosition,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    void centerOnUserPosition() {
      if (userPosition != null) {
        mapController.move(
          LatLng(
            userPosition!.latitude,
            userPosition!.longitude,
          ),
          5,
        );
      }
    }

    void centerOnHeroPosition() {
      mapController.move(
        LatLng(
          selectedHero.latitude,
          selectedHero.longitude,
        ),
        5,
      );
    }

    return Column(
      children: [
        SizedBox(
          height: constraints.maxHeight / 1.8,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(
                selectedHero.latitude,
                selectedHero.longitude,
              ),
              zoom: 5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      selectedHero.latitude,
                      selectedHero.longitude,
                    ),
                    builder: (context) => const FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.red,
                    ),
                  ),
                  if (userPosition != null) ...[
                    Marker(
                      point: LatLng(
                        userPosition!.latitude,
                        userPosition!.longitude,
                      ),
                      builder: (context) => const FaIcon(
                        FontAwesomeIcons.locationDot,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight / 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () => centerOnHeroPosition(),
              child: Row(
                children: [
                  Material(
                    color: Colors.red,
                    child: SizedBox.square(
                      dimension: constraints.maxHeight / 32,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Superhero",
                    textScaleFactor: textScaleFactor(context),
                    style: const TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () => centerOnUserPosition(),
              child: Row(
                children: [
                  Material(
                    color: Colors.blue,
                    child: SizedBox.square(
                      dimension: constraints.maxHeight / 32,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Vous",
                    textScaleFactor: textScaleFactor(context),
                    style: const TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
