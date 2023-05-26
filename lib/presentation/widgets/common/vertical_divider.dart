import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: CustomColors.white,
      thickness: 3,
      width: 3,
    );
  }
}
