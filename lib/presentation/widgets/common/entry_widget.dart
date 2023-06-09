import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class CustomEntryWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String labelText;
  final String hintText;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final int maxLines;
  const CustomEntryWidget({
    super.key,
    this.textEditingController,
    required this.labelText,
    required this.hintText,
    this.isObscureText = false,
    this.validator,
    this.initialValue,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(fontSize: 12),
      initialValue: initialValue,
      validator: validator,
      controller: textEditingController,
      obscureText: isObscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: CustomColors.lightBlue,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: CustomColors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.grey,
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
