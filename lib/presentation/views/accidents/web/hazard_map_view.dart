import 'package:e_rose/controllers/hazard_map_controller.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_declaration_popup.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_map_widget.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_searchbar.dart';
import 'package:e_rose/presentation/widgets/common/dropdown_widget.dart';
import 'package:e_rose/presentation/widgets/common/map_location_dot.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:e_rose/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

class HazardMapViewWeb extends ConsumerWidget {
  final MapController mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  HazardMapViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hazardMapController = ref.read(hazardMapControllerProvider.notifier);
    final data = ref.watch(hazardMapControllerProvider);

    return PageTemplateWidget(
      horizontalPaddingMultiplier: 20,
      verticalPaddingMultiplier: 20,
      child: data.when(
        data: (accidentMapState) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Expanded(
              child: HazardMapWidget(
                center: accidentMapState.initialPosition,
                mapController: mapController,
                markers: [
                  for (var hazard in accidentMapState.displayedHazards) ...[
                    Marker(
                      point: LatLng(
                        hazard.latitude,
                        hazard.longitude,
                      ),
                      builder: (context) => InkWell(
                        mouseCursor: SystemMouseCursors.click,
                        onTap: () async {
                          final heroes = await hazardMapController
                              .getHazardHeroes(hazard.accidentType);
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (_) => HazardHeroesPopup(
                                isConfirmation: false,
                                heroes: heroes,
                                hazardPos: LatLng(
                                  hazard.latitude,
                                  hazard.longitude,
                                ),
                              ),
                            );
                          }
                        },
                        child: MapLocationDotWidget(
                          tooltip:
                              "${hazard.description}${hazard.createdAt != null ? "\n ${DateFormat('dd/MM/yyyy, à HH:mm').format(hazard.createdAt!)}" : ""}",
                          iconCode: hazard.accidentType.iconCode,
                          iconFontFamily: hazard.accidentType.iconFontFamily,
                          iconFontPackage: hazard.accidentType.iconFontPackage,
                        ),
                      ),
                    ),
                  ],
                ],
                additionalWidgets: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                child: DropdownWidget(
                                  onChanged: (Object? accidentType) {
                                    if (accidentType != null) {
                                      hazardMapController.selectAccident(
                                          accidentType as AccidentTypeModel);
                                    }
                                  },
                                  hintText: "Filtrer par type d'accident",
                                  initialValue:
                                      accidentMapState.selectedAccidentType,
                                  items: accidentMapState.accidentsTypes.map(
                                    (AccidentTypeModel accidentType) {
                                      return DropdownMenuItem(
                                        value: accidentType,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FaIcon(
                                              IconData(
                                                int.parse(
                                                    accidentType.iconCode!),
                                                fontFamily:
                                                    accidentType.iconFontFamily,
                                                fontPackage: accidentType
                                                    .iconFontPackage,
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
                              ),
                              const SizedBox(width: 10),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.lightBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => hazardMapController
                                        .resetAccidentFilter(),
                                    icon: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: CustomColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          HazardSearchBarWidget(
                            resetOnPressed: () {
                              _searchController.text = "";
                              hazardMapController.resetQueryFilter();
                            },
                            searchOnPressed: () => hazardMapController
                                .search(_searchController.text),
                            controller: _searchController,
                          ),
                          CustomPrimaryButton(
                            onPressed: () =>
                                context.go(Routes.accidentTypeList),
                            text: "Types d'accident",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
