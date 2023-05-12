import 'package:e_rose/assets/colors.dart';
import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/models/hero.dart';
import 'package:flutter/material.dart';

class HeroCardInfoWidget extends StatelessWidget {
  final HeroModel selectedHero;
  const HeroCardInfoWidget({
    super.key,
    required this.selectedHero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _RichtTextHeroCard(
          field: "Prénom",
          value: selectedHero.firstName,
        ),
        _RichtTextHeroCard(
          field: "Nom",
          value: selectedHero.lastName,
        ),
        _RichtTextHeroCard(
          field: "Mail",
          value: selectedHero.email,
        ),
        _RichtTextHeroCard(
          field: "Téléphone",
          value: selectedHero.phoneNumber,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: white,
                width: 5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: selectedHero.accidents!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Text(
                  selectedHero.accidents![index].name!,
                  textScaleFactor: textScaleFactor(context),
                  style: const TextStyle(
                    fontSize: 8,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        RichText(
          textScaleFactor: textScaleFactor(context),
          text: TextSpan(
            style: const TextStyle(
              color: white,
              fontSize: 12,
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
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
