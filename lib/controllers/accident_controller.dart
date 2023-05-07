import 'package:e_rose/models/accident.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accident_controller.g.dart';
part 'accident_controller.freezed.dart';

@freezed
class AccidentState with _$AccidentState {
  const factory AccidentState({
    required List<Accident> accidents,
    required Accident selectedAccident,
  }) = _AccidentState;
}

@riverpod
class AccidentController extends _$AccidentController {
  @override
  FutureOr<AccidentState> build() async {
    final accidents = [
      Accident(
        id: 1,
        name: "Incendie",
        description:
            "Le feu ça brûle.\nSi vous voyez une habitation, un bâtiment public ou toutes poubelles entrain de brûler, signalez le au plus vite !",
        iconCode: Icons.fire_truck_outlined.codePoint,
        iconFont: Icons.fire_truck_outlined.fontFamily,
        iconPackage: Icons.fire_truck_outlined.fontPackage,
      ),
      Accident(
        id: 2,
        name: "Accident routier",
        description:
            "Un carambolage ? Un débris sur la route ou tout simplement une voiture emmanchée dans un platane ?\nAlors vous êtes dans la bonne catégorie",
        iconCode: FontAwesomeIcons.carBurst.codePoint,
        iconFont: FontAwesomeIcons.carBurst.fontFamily,
        iconPackage: FontAwesomeIcons.carBurst.fontPackage,
      ),
      Accident(
        id: 3,
        name: "Accident fluviale",
        description:
            "Un bateau est censé être sur l'eau, ni sur terre ni sous l'eau",
        iconCode: Icons.tsunami.codePoint,
        iconFont: Icons.tsunami.fontFamily,
        iconPackage: Icons.tsunami.fontPackage,
      ),
      Accident(
        id: 4,
        name: "Accident aérien",
        description:
            "Un avion au sol qui n'est pas sur ces roues, ou qui est éventré",
        iconCode: FontAwesomeIcons.planeCircleExclamation.codePoint,
        iconFont: FontAwesomeIcons.planeCircleExclamation.fontFamily,
        iconPackage: FontAwesomeIcons.planeCircleExclamation.fontPackage,
      ),
      Accident(
        id: 5,
        name: "Eboulement",
        description:
            "Si vous constatez des rochers sur la routes ou bien sur votre maison (celles de vos voisins comprises)",
        iconCode: Icons.landslide_outlined.codePoint,
        iconFont: Icons.landslide_outlined.fontFamily,
        iconPackage: Icons.landslide_outlined.fontPackage,
      ),
      Accident(
        id: 6,
        name: "Invasion de serpent",
        description:
            "Les serpents n'ont rien à faire en liberté en plein centre-ville !",
        iconCode: FontAwesomeIcons.staffSnake.codePoint,
        iconFont: FontAwesomeIcons.staffSnake.fontFamily,
        iconPackage: FontAwesomeIcons.staffSnake.fontPackage,
      ),
      Accident(
        id: 7,
        name: "Fuite de gaz",
        description:
            "Attention les flatulences de vos camarades ne sont pas inclues",
        iconCode: FontAwesomeIcons.explosion.codePoint,
        iconFont: FontAwesomeIcons.explosion.fontFamily,
        iconPackage: FontAwesomeIcons.explosion.fontPackage,
      ),
      Accident(
        id: 8,
        name: "Manifestation",
        description: "Si vous voyez des pavés ou des molotovs voler",
        iconCode: FontAwesomeIcons.personMilitaryRifle.codePoint,
        iconFont: FontAwesomeIcons.personMilitaryRifle.fontFamily,
        iconPackage: FontAwesomeIcons.personMilitaryRifle.fontPackage,
      ),
      Accident(
        id: 9,
        name: "Braquage",
        description:
            "En général cet incident est caractérisé par des personnes cagoulées entrain de voler d'autres personnes.\nCependant parfois elles peuvent aussi se revêtir d'un costume cravate.",
        iconCode: FontAwesomeIcons.sackDollar.codePoint,
        iconFont: FontAwesomeIcons.sackDollar.fontFamily,
        iconPackage: FontAwesomeIcons.sackDollar.fontPackage,
      ),
      Accident(
        id: 10,
        name: "Evasion de prisonnier",
        description:
            "Une personne habillée en tenue de prisonnier (hors halloween)",
        iconCode: FontAwesomeIcons.personRunning.codePoint,
        iconFont: FontAwesomeIcons.personRunning.fontFamily,
        iconPackage: FontAwesomeIcons.personRunning.fontPackage,
      ),
    ];
    return AccidentState(
      accidents: accidents,
      selectedAccident: accidents.first,
    );
  }

  void select(Accident accident) {
    state = AsyncData(
      state.value!.copyWith(selectedAccident: accident),
    );
  }
}
