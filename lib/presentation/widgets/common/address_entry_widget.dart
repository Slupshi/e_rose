import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/common/entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressEntryWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function() searchOnPressed;
  final String? Function(String?)? validator;
  const AddressEntryWidget({
    super.key,
    required this.textEditingController,
    required this.searchOnPressed,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomEntryWidget(
          textEditingController: textEditingController,
          labelText: "Adresse",
          hintText: "Cliquez sur la carte",
          validator: validator,
        ),
        Positioned(
          right: 10,
          child: IconButton(
            onPressed: searchOnPressed,
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: CustomColors.lighGrey,
            ),
          ),
        )
      ],
    );
  }
}
