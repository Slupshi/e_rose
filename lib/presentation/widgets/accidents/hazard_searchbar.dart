import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HazardSearchBarWidget extends StatelessWidget {
  final void Function() resetOnPressed;
  final void Function() searchOnPressed;
  final TextEditingController controller;
  const HazardSearchBarWidget({
    super.key,
    required this.resetOnPressed,
    required this.searchOnPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      constraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: MediaQuery.of(context).size.width / 4,
      ),
      hintText: "Rechercher par nom de ville",
      backgroundColor: MaterialStateProperty.all(CustomColors.white),
      hintStyle: MaterialStateProperty.all(
        const TextStyle(
          color: CustomColors.grey,
          fontStyle: FontStyle.italic,
        ),
      ),
      leading: IconButton(
        onPressed: searchOnPressed,
        icon: const FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          color: CustomColors.grey,
        ),
      ),
      side: MaterialStateProperty.all(BorderSide.none),
      trailing: [
        IconButton(
          onPressed: resetOnPressed,
          icon: const FaIcon(
            FontAwesomeIcons.xmark,
            color: CustomColors.grey,
          ),
        ),
      ],
    );
  }
}
