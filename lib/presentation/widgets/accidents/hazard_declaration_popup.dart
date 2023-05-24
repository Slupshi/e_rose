import 'package:e_rose/controllers/hazard_declaration_controller.dart';
import 'package:e_rose/models/hero.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class HazardHeroesPopup extends ConsumerWidget {
  final List<HeroModel> heroes;
  final LatLng hazardPos;
  final bool isConfirmation;
  const HazardHeroesPopup({
    super.key,
    required this.heroes,
    required this.hazardPos,
    this.isConfirmation = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final declarationController =
        ref.read(hazardDeclarationControllerProvider.notifier);
    List<HeroModel> orderedHeroes = [...heroes];
    List<HeroModel> nearestHeroes = [];
    if (orderedHeroes.isNotEmpty) {
      orderedHeroes.sort((a, b) => declarationController
          .getDistance(a, hazardPos)!
          .compareTo(declarationController.getDistance(b, hazardPos)!));
      nearestHeroes = orderedHeroes
          .where((hero) =>
              //declarationController.getDistance(hero) != null &&
              declarationController.getDistance(hero, hazardPos)! < 50)
          .toList();
      for (var hero in nearestHeroes) {
        orderedHeroes.remove(hero);
      }
    }

    return AlertDialog(
      title: isConfirmation ? const Text("Déclaration effectuée !") : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isConfirmation) ...[
            const Text(
              "Votre déclaration a été effectué avec succès.",
            ),
            const SizedBox(height: 20),
          ],
          heroes.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Les plus proches (-50Km) :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    nearestHeroes.isEmpty
                        ? const Text(
                            "Il n'y a aucun héro à proximité",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : SizedBox(
                            height: 100,
                            width: 400,
                            child: ListView.builder(
                              itemCount: nearestHeroes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      nearestHeroes[index].heroName,
                                    ),
                                    Text(
                                      declarationController.getDistance(
                                                nearestHeroes[index],
                                                hazardPos,
                                              ) ==
                                              null
                                          ? "N/A"
                                          : "${declarationController.getDistance(nearestHeroes[index], hazardPos)}Km",
                                    ),
                                    Text(
                                      "Tel : ${nearestHeroes[index].phoneNumber}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Text(
                      "En renforts :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    orderedHeroes.isNotEmpty
                        ? SizedBox(
                            height: 100,
                            width: 400,
                            child: ListView.builder(
                              itemCount: orderedHeroes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderedHeroes[index].heroName,
                                    ),
                                    Text(
                                      declarationController.getDistance(
                                                orderedHeroes[index],
                                                hazardPos,
                                              ) ==
                                              null
                                          ? "N/A"
                                          : "${declarationController.getDistance(orderedHeroes[index], hazardPos)}Km",
                                    ),
                                    Text(
                                      "Tel : ${orderedHeroes[index].phoneNumber}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Il n'y a malheureusement aucun renfort disponible",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: CustomColors.grey,
                              ),
                            ),
                          ),
                  ],
                )
              : const Center(
                  child: Text(
                    "Aucun héro n'est disponible pour gérer cette situation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
