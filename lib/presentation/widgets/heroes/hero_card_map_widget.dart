import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/models/hero.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_map_widget.dart';
import 'package:e_rose/presentation/widgets/common/map_location_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
        HazardMapWidget(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight / 1.8,
          ),
          mapController: mapController,
          center: LatLng(
            selectedHero.latitude,
            selectedHero.longitude,
          ),
          markers: [
            Marker(
              point: LatLng(
                selectedHero.latitude,
                selectedHero.longitude,
              ),
              builder: (context) => MapLocationDotWidget(
                tooltip: selectedHero.heroName,
              ),
            ),
            if (userPosition != null) ...[
              Marker(
                point: LatLng(
                  userPosition!.latitude,
                  userPosition!.longitude,
                ),
                builder: (context) => const MapLocationDotWidget(
                  color: CustomColors.lightBlue,
                  tooltip: "Vous",
                ),
              ),
            ],
          ],
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
                    color: CustomColors.red,
                    child: SizedBox.square(
                      dimension: constraints.maxHeight / 32,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedHero.heroName,
                    textScaleFactor: textScaleFactor(context),
                    style: const TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            if (userPosition != null) ...[
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                onTap: () => centerOnUserPosition(),
                child: Row(
                  children: [
                    Material(
                      color: CustomColors.lightBlue,
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
          ],
        )
      ],
    );
  }
}
