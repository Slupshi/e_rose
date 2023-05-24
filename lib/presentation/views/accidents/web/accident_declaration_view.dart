import 'package:e_rose/controllers/declaration_controller.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/address.dart';
import 'package:e_rose/models/declaration.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/accidents/declaration_popup.dart';
import 'package:e_rose/presentation/widgets/common/entry_widget.dart';
import 'package:e_rose/presentation/widgets/common/vertical_divider.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class AccidentDeclarationViewWeb extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final MapController mapController = MapController();
  AccidentDeclarationViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(declarationControllerProvider);
    final DeclarationController declarationController =
        ref.read(declarationControllerProvider.notifier);
    return PageTemplateWidget(
      child: data.when(
        data: (declarationState) {
          final TextEditingController addressController = TextEditingController(
            text: GeoLocatorService.displayAddress(
              declarationState.selectedAddress,
            ),
          );
          final TextEditingController cityNameController =
              TextEditingController(
            text: declarationState.selectedAddress?.town ??
                declarationState.selectedAddress?.city,
          );
          final TextEditingController descriptionController =
              TextEditingController(
            text: _getDescriptionInitialValue(
              declarationState.selectedAddress,
              declarationState.selectedAccidentType,
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
                            items: declarationState.accidentTypes
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
                                    Text(accidentType.name!),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Object? accidentType) {
                              if (accidentType != null) {
                                declarationController.selectAccident(
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
                          CustomEntryWidget(
                            textEditingController: addressController,
                            labelText: "Adresse",
                            hintText: "Cliquez sur la carte",
                            validator: (value) => value == null ||
                                    declarationState.selectedPos == null
                                ? "Il vous faut une adresse"
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
                                  declarationState.selectedAccidentType !=
                                      null) {
                                final isError = !await declarationController
                                    .declareAccident(
                                  DeclarationModel(
                                    cityName: addressController.text
                                        .split(", ")
                                        .first,
                                    description: descriptionController.text,
                                    accidentType:
                                        declarationState.selectedAccidentType!,
                                    latitude:
                                        declarationState.selectedPos!.latitude,
                                    longitude:
                                        declarationState.selectedPos!.longitude,
                                  ),
                                );
                                if (!isError && context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeclarationConfirmationPopup(
                                      heroes: declarationState.possibleHeroes,
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
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.white,
                              width: 5,
                            ),
                          ),
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              zoom: 5,
                              onTap: (tapPosition, point) async {
                                await declarationController
                                    .selectMapPoint(point);
                              },
                            ),
                            children: [
                              // MarkerLayer(
                              //   markers: [
                              //     if (declarationState.selectedPos != null) ...[
                              //       Marker(
                              //         point: declarationState.selectedPos!,
                              //         builder: (context) => const FaIcon(
                              //           FontAwesomeIcons.locationDot,
                              //           color: CustomColors.red,
                              //         ),
                              //       ),
                              //     ],
                              //   ],
                              // ),
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                            ],
                          ),
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
                              mapController.move(pos, 8);
                              declarationController.selectMapPoint(pos);
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
