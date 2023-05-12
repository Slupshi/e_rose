import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/hero_controller.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/heroes/hero_card_info_widget.dart';
import 'package:e_rose/presentation/widgets/heroes/hero_card_map_widget.dart';
import 'package:e_rose/presentation/widgets/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:latlong2/latlong.dart";

class HeroesListViewWeb extends ConsumerWidget {
  const HeroesListViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MapController mapController = MapController();
    final heroController = ref.read(heroControllerProvider.notifier);
    final data = ref.watch(heroControllerProvider);
    return PageTemplateWidget(
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
                    flex: 1,
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
                                      ? CustomColors.lighGrey.withOpacity(0.1)
                                      : Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      heroController.select(hero);
                                      mapController.move(
                                        LatLng(
                                          hero.latitude,
                                          hero.longitude,
                                        ),
                                        5,
                                      );
                                    },
                                    hoverColor:
                                        CustomColors.lighGrey.withOpacity(0.1),
                                    child: SizedBox(
                                      height: constraints.maxHeight / 12,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: constraints.maxWidth / 10,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textScaleFactor:
                                                textScaleFactor(context),
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: hero.heroName,
                                                  style: const TextStyle(
                                                    color: CustomColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "  (${heroController.getDistance(hero).toString()})",
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    fontStyle: FontStyle.italic,
                                                    color: CustomColors.grey,
                                                  ),
                                                ),
                                              ],
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
                    color: CustomColors.white,
                    thickness: 3,
                    width: 3,
                  ),
                  Flexible(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (heroState.selectedhero != null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth / 10,
                              vertical: constraints.maxHeight / 20,
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    heroState.selectedhero!.heroName,
                                    textScaleFactor: textScaleFactor(context),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight / 25,
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight / 1.4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: HeroCardInfoWidget(
                                            selectedHero:
                                                heroState.selectedhero!,
                                          ),
                                        ),
                                        Expanded(
                                          child: HeroCardMapWidget(
                                            mapController: mapController,
                                            selectedHero:
                                                heroState.selectedhero!,
                                            userPosition:
                                                heroState.userPosition,
                                            constraints: constraints,
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
    );
  }
}
