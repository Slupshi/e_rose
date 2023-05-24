import 'package:e_rose/controllers/hazard_map_controller.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_searchbar.dart';
import 'package:e_rose/presentation/widgets/common/dropdown_widget.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:e_rose/router/routes.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class HazardMapViewWeb extends ConsumerWidget {
  final MapController mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  HazardMapViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accidentMapController =
        ref.read(hazardMapControllerProvider.notifier);
    final data = ref.watch(hazardMapControllerProvider);
    return PageTemplateWidget(
      horizontalPaddingMultiplier: 20,
      verticalPaddingMultiplier: 20,
      child: data.when(
        data: (accidentMapState) => Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DropdownWidget(
                          onChanged: (Object? accidentType) {
                            if (accidentType != null) {
                              accidentMapController.selectAccident(
                                  accidentType as AccidentTypeModel);
                            }
                          },
                          hintText: "Filtrer par type d'accident",
                          initialValue: accidentMapState.selectedAccidentType,
                          items: accidentMapState.accidentsTypes.map(
                            (AccidentTypeModel accidentType) {
                              return DropdownMenuItem(
                                value: accidentType,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      IconData(
                                        int.parse(accidentType.iconCode!),
                                        fontFamily: accidentType.iconFontFamily,
                                        fontPackage:
                                            accidentType.iconFontPackage,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(accidentType.name!),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () =>
                                accidentMapController.resetAccidentFilter(),
                            icon: const FaIcon(
                              FontAwesomeIcons.xmark,
                              color: CustomColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    HazardSearchBarWidget(
                      resetOnPressed: () {
                        _searchController.text = "";
                        accidentMapController.resetQueryFilter();
                      },
                      searchOnPressed: () =>
                          accidentMapController.search(_searchController.text),
                      controller: _searchController,
                    ),
                    CustomPrimaryButton(
                      onPressed: () => context.go(Routes.accidentTypeList),
                      text: "Types d'accident",
                    ),
                  ],
                ),
              ),
              const Divider(
                color: CustomColors.white,
                thickness: 3,
              ),
              Expanded(
                flex: 10,
                child: Stack(
                  children: [
                    Positioned(
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          maxZoom: 18,
                          minZoom: 3,
                          zoom: 5,
                          keepAlive: true,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              for (var hazard
                                  in accidentMapState.displayedHazards) ...[
                                Marker(
                                  point: LatLng(
                                    hazard.latitude,
                                    hazard.longitude,
                                  ),
                                  builder: (context) => Tooltip(
                                    message: hazard.description,
                                    child: FaIcon(
                                      IconData(
                                        int.parse(
                                            hazard.accidentType.iconCode!),
                                        fontFamily:
                                            hazard.accidentType.iconFontFamily,
                                        fontPackage:
                                            hazard.accidentType.iconFontPackage,
                                      ),
                                      color: CustomColors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Material(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: IconButton(
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
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
