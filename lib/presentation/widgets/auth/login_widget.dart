import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/auth_controller.dart';
import 'package:e_rose/services/api/dto/auth/login_model.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginWidget extends ConsumerWidget {
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
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
          TextFormField(
            controller: _emailLoginController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Email",
              labelStyle: const TextStyle(color: CustomColors.lightBlue),
              filled: true,
              fillColor: CustomColors.white,
              hintText: "john.doe@gmail.com",
              hintStyle: const TextStyle(
                color: CustomColors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          TextFormField(
            controller: _passwordLoginController,
            obscureText: true,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Mot de passe",
              labelStyle: const TextStyle(color: CustomColors.lightBlue),
              filled: true,
              fillColor: CustomColors.white,
              hintText: "password",
              hintStyle: const TextStyle(
                color: CustomColors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          CustomPrimaryButton(
            onPressed: () async {
              final isLogged =
                  await ref.read(authControllerProvider.notifier).login(
                        LoginModel(
                          email: _emailLoginController.text,
                          password: _passwordLoginController.text,
                        ),
                      );
              if (isLogged) {
                context.go("/");
              }
            },
            text: "Connexion",
          ),
        ],
      ),
    );
  }
}
