import 'package:e_rose/controllers/login_controller.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class UserProfileViewWeb extends ConsumerWidget {
  const UserProfileViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplateWidget(
      child: Center(
        child: Material(
          elevation: 30,
          color: CustomColors.red,
          shape: const CircleBorder(),
          child: IconButton(
            tooltip: "Se déconnecter",
            padding: const EdgeInsets.all(20),
            onPressed: () {
              ref.read(loginControllerProvider.notifier).disconnect();
              context.go(Routes.homePage);
            },
            iconSize: MediaQuery.of(context).size.height / 4,
            icon: const FaIcon(
              FontAwesomeIcons.powerOff,
              color: CustomColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
