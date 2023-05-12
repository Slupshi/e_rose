import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: webPagePadding,
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: MediaQuery.of(context).size.width / 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Déclarer un incident",
                          textScaleFactor: textScaleFactor(context),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Si vous appercevez un incident, déclarez le au plus vite !",
                          textScaleFactor: textScaleFactor(context),
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(flex: 2),
                            Flexible(
                              flex: 5,
                              child: CustomPrimaryButton(
                                onPressed: () {},
                                text: "Je le déclare !",
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 5,
                              child: CustomPrimaryButton(
                                onPressed: () {},
                                text: "Découvrir les incidents",
                              ),
                            ),
                            const Spacer(flex: 6),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: CustomColors.white,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          children: [
                            Positioned(
                              top: constraints.maxHeight / 6,
                              left: constraints.maxWidth / 6,
                              child: Icon(
                                Icons.tsunami,
                                color: CustomColors.white,
                                size: constraints.maxHeight / 4,
                              ),
                            ),
                            Positioned(
                              bottom: constraints.maxHeight / 7,
                              right: constraints.maxWidth / 7,
                              child: Icon(
                                Icons.fire_truck_outlined,
                                color: CustomColors.white,
                                size: constraints.maxHeight / 4,
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight / 8,
                              right: constraints.maxWidth / 8,
                              child: FaIcon(
                                FontAwesomeIcons.carBurst,
                                color: CustomColors.white,
                                size: constraints.maxHeight / 4,
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight / 2,
                              left: constraints.maxWidth / 4,
                              child: Icon(
                                Icons.landslide_outlined,
                                color: CustomColors.white,
                                size: constraints.maxHeight / 4,
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight / 3,
                              left: constraints.maxWidth / 2,
                              child: FaIcon(
                                FontAwesomeIcons.truckMedical,
                                color: CustomColors.white,
                                size: constraints.maxHeight / 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: CustomColors.white,
            indent: MediaQuery.of(context).size.width / 10,
            endIndent: MediaQuery.of(context).size.width / 10,
            thickness: 3,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) => FaIcon(
                          FontAwesomeIcons.mask,
                          color: CustomColors.white,
                          size: constraints.maxHeight / 2,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Les super héros !",
                          textScaleFactor: textScaleFactor(context),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Soyez en sécurité grâce aux héros qui veillent !",
                          textScaleFactor: textScaleFactor(context),
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Si vous sentez votre courage monter, n'attendez plus pour vous inscrire !",
                          textScaleFactor: textScaleFactor(context),
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(flex: 2),
                            Flexible(
                              flex: 5,
                              child: CustomPrimaryButton(
                                onPressed: () {},
                                text: "Découvrir",
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 5,
                              child: CustomPrimaryButton(
                                onPressed: () {},
                                text: "S'inscire",
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
