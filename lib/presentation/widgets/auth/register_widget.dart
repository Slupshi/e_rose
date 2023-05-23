import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterWidget extends ConsumerWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enregistrement",
            textScaleFactor: textScaleFactor(context),
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          Text(
            "Vous avez une âme de superhéro ?",
            textScaleFactor: textScaleFactor(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          Text(
            "Et souhaitez aider votre prochain ?",
            textScaleFactor: textScaleFactor(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          CustomPrimaryButton(
            onPressed: () => context.go("/register"),
            text: "S'enregistrer",
          ),
        ],
      ),
    );
  }
}
