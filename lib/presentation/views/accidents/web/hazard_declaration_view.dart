import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/hazard_declaration_controller.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/address.dart';
import 'package:e_rose/models/hazard_model.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_declaration_popup.dart';
import 'package:e_rose/presentation/widgets/accidents/hazard_map_widget.dart';
import 'package:e_rose/presentation/widgets/common/address_entry_widget.dart';
import 'package:e_rose/presentation/widgets/common/entry_widget.dart';
import 'package:e_rose/presentation/widgets/common/map_location_dot.dart';
import 'package:e_rose/presentation/widgets/common/vertical_divider.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class HazardDeclarationViewWeb extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final MapController mapController = MapController();
  HazardDeclarationViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HazardDeclarationController hazardDeclarationController =
        ref.read(hazardDeclarationControllerProvider.notifier);
    final data = ref.watch(hazardDeclarationControllerProvider);
    return PageTemplateWidget(
      child: data.when(
        data: (hazardDeclarationState) {
          final TextEditingController addressController = TextEditingController(
            text: GeoLocatorService.displayAddress(
              hazardDeclarationState.selectedAddress,
            ),
          );
          final TextEditingController cityNameController =
              TextEditingController(
            text: hazardDeclarationState.selectedAddress?.town ??
                hazardDeclarationState.selectedAddress?.city,
          );
          final TextEditingController descriptionController =
              TextEditingController(
            text: _getDescriptionInitialValue(
              hazardDeclarationState.selectedAddress,
              hazardDeclarationState.selectedAccidentType,
            ),
          );
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButtonFormField(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              hintText: "Sélectionner un incident",
                              hintStyle: const TextStyle(
                                color: CustomColors.grey,
                              ),
                              filled: true,
                              fillColor: CustomColors.white,
                              hoverColor: CustomColors.white,
                              focusColor: CustomColors.lightBlue,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            dropdownColor: CustomColors.white,
                            items: hazardDeclarationState.accidentTypes
                                .map((AccidentTypeModel accidentType) {
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
                                    Text(
                                      accidentType.name!,
                                      textScaleFactor: textScaleFactor(context),
                                      style: const TextStyle(fontSize: 8),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Object? accidentType) {
                              if (accidentType != null) {
                                hazardDeclarationController.selectAccidentType(
                                    accidentType as AccidentTypeModel);
                              }
                            },
                            validator: (value) => value == null
                                ? "Vous devez renseignez un type d'incident"
                                : null,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomEntryWidget(
                            textEditingController: cityNameController,
                            labelText: "Ville",
                            hintText: "Saint-Etienne du Rouvray",
                            validator: (value) => value == null || value == ""
                                ? "Il vous faut préciser le nom de la ville"
                                : null,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          AddressEntryWidget(
                            textEditingController: addressController,
                            searchOnPressed: () async {
                              final pos = await hazardDeclarationController
                                  .selectPointFromAddress(
                                      addressController.text);
                              if (pos != null) {
                                mapController.move(pos, 15);
                              }
                            },
                            validator: (value) => value == null ||
                                    hazardDeclarationState.selectedPos == null
                                ? "Il vous faut valider votre adresse"
                                : null,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomEntryWidget(
                            maxLines: 5,
                            textEditingController: descriptionController,
                            labelText: "Description",
                            hintText: "Un immeuble s'enflamme au 3eme étage !",
                            validator: (value) => value == null || value == ""
                                ? "Veuillez entrer une description"
                                : null,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomPrimaryButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  hazardDeclarationState.selectedAccidentType !=
                                      null) {
                                final isError =
                                    !await hazardDeclarationController
                                        .declareHazard(
                                  HazardModel(
                                    cityName: hazardDeclarationState
                                            .selectedAddress?.town ??
                                        hazardDeclarationState
                                            .selectedAddress!.city!,
                                    description: descriptionController.text,
                                    accidentType: hazardDeclarationState
                                        .selectedAccidentType!,
                                    latitude: hazardDeclarationState
                                        .selectedPos!.latitude,
                                    longitude: hazardDeclarationState
                                        .selectedPos!.longitude,
                                  ),
                                );
                                if (!isError && context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => HazardHeroesPopup(
                                      heroes:
                                          hazardDeclarationState.possibleHeroes,
                                      hazardPos:
                                          hazardDeclarationState.selectedPos!,
                                    ),
                                  );
                                }
                              }
                            },
                            text: "Valider",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const CustomVerticalDivider(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HazardMapWidget(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 3,
                            maxHeight: MediaQuery.of(context).size.width / 4,
                          ),
                          mapController: mapController,
                          markers: [
                            if (hazardDeclarationState.selectedPos != null) ...[
                              Marker(
                                point: hazardDeclarationState.selectedPos!,
                                builder: (context) =>
                                    const MapLocationDotWidget(
                                  tooltip: "",
                                ),
                              ),
                            ],
                          ],
                          onTap: (_, point) async {
                            await hazardDeclarationController
                                .selectMapPoint(point);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 45,
                        ),
                        CustomPrimaryButton(
                          onPressed: () async {
                            final userPosition =
                                await GeoLocatorService.determinePosition();
                            if (userPosition != null) {
                              final pos = LatLng(
                                userPosition.latitude,
                                userPosition.longitude,
                              );
                              mapController.move(pos, 13);
                              hazardDeclarationController.selectMapPoint(pos);
                            }
                          },
                          text: "Votre position",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () =>
            const PageTemplateWidget(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }

  String? _getDescriptionInitialValue(
      Address? address, AccidentTypeModel? accident) {
    return "${accident?.name ?? "Situation inconnue"} situé(e) à ${address?.town ?? (address?.city ?? "Ville inconnue")}";
  }
}
