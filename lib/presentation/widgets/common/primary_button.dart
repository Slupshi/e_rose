import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  const CustomPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = CustomColors.lightBlue,
    this.foregroundColor = CustomColors.white,
    this.borderColor = CustomColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(35)),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide.none, //BorderSide(color: borderColor, width: 1),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
