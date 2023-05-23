import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/register_controller.dart';
import 'package:e_rose/models/accident.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/common/dropdown_widget.dart';
import 'package:e_rose/presentation/widgets/common/entry_widget.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:e_rose/presentation/widgets/common/primary_button.dart';
import 'package:e_rose/services/api/dto/auth/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class RegisterViewWeb extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heroNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegisterViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerController = ref.read(registerControllerProvider.notifier);
    final data = ref.watch(registerControllerProvider);
    return PageTemplateWidget(
      child: data.when(
        data: (registerState) {
          final TextEditingController addressController =
              TextEditingController(text: registerState.address);
          if (registerState.allReadyTakenErrorMessage != null) {
            Future.delayed(
              Duration.zero,
              () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(registerState.allReadyTakenErrorMessage!),
                ),
              ),
            );
          }
          return Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomEntryWidget(
                                textEditingController: _heroNameController,
                                labelText: "Nom de héro",
                                hintText: "Superman",
                                validator: (value) => (value != null &&
                                        value.length < 4)
                                    ? "Votre nom doit faire plus de 3 caractères"
                                    : null,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45),
                              CustomEntryWidget(
                                textEditingController: _emailController,
                                labelText: "Email",
                                hintText: "super.man@erose.com",
                                validator: (value) => value != null &&
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)
                                    ? "L'email n'est pas valide"
                                    : null,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45),
                              CustomEntryWidget(
                                textEditingController: _passwordController,
                                labelText: "Mot de passe",
                                hintText: "password",
                                isObscureText: true,
                                validator: (value) {
                                  if (value != null &&
                                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(value)) {
                                    return "Le mot de passe doit contenir 1 majuscule, 1 minuscule, 1 caractère spécial, 1 chiffre et 8 caractères au total";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45),
                              CustomEntryWidget(
                                textEditingController:
                                    _confirmPasswordController,
                                isObscureText: true,
                                labelText: "Confirmation du mot de passe",
                                hintText: "password",
                                validator: (value) => value != null &&
                                        value != _passwordController.text
                                    ? "Les mots de passes doivent être identiques"
                                    : null,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45),
                              CustomEntryWidget(
                                textEditingController: _phoneNumberController,
                                labelText: "Téléphone",
                                hintText: "0601020304",
                                validator: (value) => value != null &&
                                        !RegExp(r"^(?:[+0]9)?[0-9]{10}$")
                                            .hasMatch(value)
                                    ? "Le numéro de téléphone n'est pas valide"
                                    : null,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45),
                              Wrap(
                                runSpacing: 5,
                                spacing: 10,
                                children: [
                                  for (var accident
                                      in registerState.selectedAccident) ...[
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: CustomColors.lightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              accident.name!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 15,
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                registerController
                                                    .unSelectAccident(accident);
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons.xmark,
                                                size: 15,
                                                color: CustomColors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 20),
                              DropdownWidget(
                                onChanged: (Object? accident) {
                                  if (accident != null) {
                                    registerController
                                        .selectAccident(accident as Accident);
                                  }
                                },
                                hintText: "Sélectionnez un incident",
                                items: registerState.accidents
                                    .map((Accident accident) {
                                  return DropdownMenuItem(
                                    value: accident,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          IconData(
                                            int.parse(accident.iconCode!),
                                            fontFamily: accident.iconFontFamily,
                                            fontPackage:
                                                accident.iconFontPackage,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(accident.name!),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                registerState.accidentsErrorType ==
                                        SelectedAccidentsErrorType.none
                                    ? ""
                                    : registerState.accidentsErrorType ==
                                            SelectedAccidentsErrorType.tooMany
                                        ? "Vous ne pouvez vous occuper que de 3 situations différentes !"
                                        : "Ne soyez pas timide, choisissez une situation !",
                                textScaleFactor: textScaleFactor(context),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: CustomColors.red,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomColors.white,
                                width: 5,
                              ),
                            ),
                            child: FlutterMap(
                              options: MapOptions(
                                zoom: 5,
                                onTap: (tapPosition, point) async {
                                  await registerController
                                      .selectMapPoint(point);
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomPrimaryButton(
                            onPressed: () {},
                            text: "Votre position",
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomEntryWidget(
                            textEditingController: addressController,
                            labelText: "Adresse",
                            hintText: "Cliquez sur la carte",
                            validator: (value) => value == null ||
                                    registerState.selectedPos == null
                                ? "Il vous faut une adresse"
                                : null,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 45),
                          CustomPrimaryButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (registerState.selectedAccident.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Je rectifie !"),
                                        )
                                      ],
                                      content: const Text(
                                        "Vous devez sélectionner entre 1 et 3 types d'incidents",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                final isRegistered =
                                    await registerController.register(
                                  RegisterModel(
                                    heroName: _heroNameController.text,
                                    email: _emailController.text,
                                    phoneNumber: _phoneNumberController.text,
                                    password: _passwordController.text,
                                    latitude:
                                        registerState.selectedPos!.latitude,
                                    longitude:
                                        registerState.selectedPos!.longitude,
                                    accidents: registerState.selectedAccident,
                                  ),
                                );
                                if (isRegistered) {
                                  if (context.mounted) {
                                    context.go("/");
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(
                                          "Vous êtes maintenant connecté en tant que ${_heroNameController.text}",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            text: "S'enregistrer",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () =>
            const PageTemplateWidget(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
