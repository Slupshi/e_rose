import 'package:e_rose/controllers/declaration_controller.dart';
import 'package:e_rose/models/hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeclarationConfirmationPopup extends ConsumerWidget {
  final List<HeroModel> heroes;
  const DeclarationConfirmationPopup({
    super.key,
    required this.heroes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final declarationController =
        ref.read(declarationControllerProvider.notifier);
    final orderedHeroes = [...heroes];
    orderedHeroes.sort((a, b) => declarationController
        .getDistance(a)!
        .compareTo(declarationController.getDistance(b)!));
    final nearestHeroes = orderedHeroes
        .where((hero) =>
            //declarationController.getDistance(hero) != null &&
            declarationController.getDistance(hero)! < 50)
        .toList();
    return AlertDialog(
      title: const Text("Déclaration effectuée !"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Votre déclaration a été effectué avec succès.",
          ),
          const SizedBox(height: 20),
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
                                                  nearestHeroes[index]) ==
                                              null
                                          ? "N/A"
                                          : "${declarationController.getDistance(nearestHeroes[index])}Km",
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
                      "Au cas où :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      width: 400,
                      child: ListView.builder(
                        itemCount: orderedHeroes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                orderedHeroes[index].heroName,
                              ),
                              Text(
                                declarationController.getDistance(
                                            orderedHeroes[index]) ==
                                        null
                                    ? "N/A"
                                    : "${declarationController.getDistance(orderedHeroes[index])}Km",
                              ),
                              Text(
                                "Tel : ${orderedHeroes[index].phoneNumber}",
                              ),
                            ],
                          ),
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
