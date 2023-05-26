import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final void Function(Object?)? onChanged;
  final Object? initialValue;
  final List<DropdownMenuItem<Object>>? items;
  final String hintText;
  final bool isDense;
  final bool isExpanded;
  const DropdownWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.items,
    this.initialValue,
    this.isDense = false,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: DropdownButton(
          isDense: isDense,
          isExpanded: isExpanded,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          hint: Text(
            hintText,
            textScaleFactor: textScaleFactor(context),
            style: const TextStyle(
              color: CustomColors.grey,
              fontSize: 8,
            ),
          ),
          value: initialValue,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
