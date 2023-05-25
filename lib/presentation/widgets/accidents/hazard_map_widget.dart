import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class HazardMapWidget extends StatelessWidget {
  final MapController mapController;
  final List<Marker> markers;
  final LatLng? center;
  final List<Widget>? additionalWidgets;
  final void Function(TapPosition, LatLng)? onTap;
  final BoxConstraints? constraints;
  const HazardMapWidget({
    super.key,
    required this.mapController,
    required this.markers,
    this.center,
    this.additionalWidgets,
    this.onTap,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.white,
          width: 5,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: onTap,
                center: center,
                maxZoom: 18,
                minZoom: 3,
                zoom: 5,
                keepAlive: true,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Material(
              color: CustomColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: IconButton(
                splashRadius: 1,
                tooltip: "Centrer sur votre position",
                onPressed: () async {
                  final userPosition =
                      await GeoLocatorService.determinePosition();
                  if (userPosition != null) {
                    mapController.move(
                      LatLng(
                        userPosition.latitude,
                        userPosition.longitude,
                      ),
                      10,
                    );
                  }
                },
                icon: const FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: CustomColors.red,
                ),
              ),
            ),
          ),
          if (additionalWidgets != null && additionalWidgets!.isNotEmpty) ...[
            for (Widget additionalWidget in additionalWidgets!) ...[
              additionalWidget,
            ]
          ],
        ],
      ),
    );
  }
}
