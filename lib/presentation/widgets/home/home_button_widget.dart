import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const HomeButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(50)),
          backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.hovered)) {
              return CustomColors.white;
            }
            return Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.hovered)) {
              return CustomColors.black;
            }
            return CustomColors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(
                color: CustomColors.white,
                width: 1,
              ),
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
