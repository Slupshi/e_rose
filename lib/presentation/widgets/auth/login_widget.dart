import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/login_controller.dart';
import 'package:e_rose/presentation/widgets/common/entry_widget.dart';
import 'package:e_rose/router/routes.dart';
import 'package:e_rose/services/api/dto/auth/login_model.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginWidget extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginWidget({super.key});

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
            "Connexion",
            textScaleFactor: textScaleFactor(context),
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          CustomEntryWidget(
            textEditingController: _emailController,
            labelText: "Email",
            hintText: "john.doe@gmail.com",
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          CustomEntryWidget(
            textEditingController: _passwordController,
            labelText: "Mot de passe",
            hintText: "password",
            isObscureText: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          CustomPrimaryButton(
            onPressed: () async {
              final isLogged =
                  await ref.read(loginControllerProvider.notifier).login(
                        LoginModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
              if (isLogged) {
                if (context.mounted) {
                  context.go(Routes.homePage);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        "Vous êtes maintenant connecté avec l'adresse email : ${_emailController.text}",
                      ),
                    ),
                  );
                }
              }
            },
            text: "Connexion",
          ),
        ],
      ),
    );
  }
}
