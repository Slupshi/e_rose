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
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: borderColor, width: 3),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
