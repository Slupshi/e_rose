import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final void Function(Object?)? onChanged;
  final Object? initialValue;
  final List<DropdownMenuItem<Object>>? items;
  final String hintText;
  const DropdownWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.items,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        hint: Text(
          hintText,
          style: const TextStyle(
            color: CustomColors.grey,
          ),
        ),
        value: initialValue,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
