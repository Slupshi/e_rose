import 'package:e_rose/assets/colors.dart';
import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/hero_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeroesListViewWeb extends ConsumerWidget {
  const HeroesListViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroController = ref.read(heroControllerProvider.notifier);
    final data = ref.watch(heroControllerProvider);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 9,
          horizontal: MediaQuery.of(context).size.width / 7,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50),
            color: darkerNightBlue,
          ),
          child: Material(
            elevation: 20,
            color: Colors.transparent,
            child: data.when(
              data: (heroState) => heroState.heroes.isEmpty
                  ? Center(
                      child: Text(
                        "Il n'y a aucun héro pour l'instant !",
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(fontSize: 15),
                      ),
                    )
                  : Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight / 15,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (var hero in heroState.heroes) ...[
                                      Material(
                                        color: hero == heroState.selectedhero
                                            ? lighGrey.withOpacity(0.1)
                                            : Colors.transparent,
                                        child: InkWell(
                                          onTap: () =>
                                              heroController.select(hero),
                                          hoverColor: lighGrey.withOpacity(0.1),
                                          child: SizedBox(
                                            height: constraints.maxHeight / 12,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: constraints.maxWidth / 10,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  hero.heroName,
                                                  textScaleFactor:
                                                      textScaleFactor(context),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: white,
                          thickness: 3,
                          width: 3,
                        ),
                        Flexible(
                          flex: 3,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (heroState.selectedhero != null) {
                                final hero = heroState.selectedhero!;
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth / 10,
                                    vertical: constraints.maxHeight / 20,
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          hero.heroName,
                                          textScaleFactor:
                                              textScaleFactor(context),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight / 25,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight / 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    _RichtTextHeroCard(
                                                      field: "Prénom",
                                                      value: hero.firstName,
                                                    ),
                                                    _RichtTextHeroCard(
                                                      field: "Nom",
                                                      value: hero.lastName,
                                                    ),
                                                    _RichtTextHeroCard(
                                                      field: "Mail",
                                                      value: hero.email,
                                                    ),
                                                    _RichtTextHeroCard(
                                                      field: "Téléphone",
                                                      value: hero.phoneNumber,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Text(
                                  "Veuillez sélectionner un héro !",
                                  textScaleFactor: textScaleFactor(context),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

class _RichtTextHeroCard extends StatelessWidget {
  final String field;
  final String? value;

  const _RichtTextHeroCard({
    required this.field,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: textScaleFactor(context),
      text: TextSpan(
        style: const TextStyle(
          color: white,
          fontSize: 13,
        ),
        children: [
          TextSpan(
            text: "$field:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(
            text: "   ",
          ),
          TextSpan(
            text: value ?? "Inconnu",
          ),
        ],
      ),
    );
  }
}
