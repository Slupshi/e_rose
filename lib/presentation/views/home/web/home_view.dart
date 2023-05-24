import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/home/home_button_widget.dart';
import 'package:e_rose/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.black.withOpacity(0.2),
      child: Row(
        children: [
          const Spacer(flex: 1),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                const Spacer(flex: 1),
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Protéger & Servir",
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Déclarez tout incident au plus vite",
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "J'aide mon prochain en m'enregistrant",
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "ou en déclarant un incident",
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          HomeButtonWidget(
                            onPressed: () =>
                                context.go(Routes.hazardDeclarationPage),
                            text: "Je déclare",
                          ),
                          const Spacer(flex: 1),
                          HomeButtonWidget(
                            onPressed: () => context.go(Routes.registerPage),
                            text: "Je m'enregistre",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
