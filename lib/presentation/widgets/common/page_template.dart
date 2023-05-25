import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';

class PageTemplateWidget extends StatelessWidget {
  final Widget child;
  final double horizontalPaddingMultiplier;
  final double verticalPaddingMultiplier;
  const PageTemplateWidget({
    super.key,
    required this.child,
    this.horizontalPaddingMultiplier = 10,
    this.verticalPaddingMultiplier = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:
              MediaQuery.of(context).size.height / verticalPaddingMultiplier,
          horizontal:
              MediaQuery.of(context).size.width / horizontalPaddingMultiplier,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50),
            color: CustomColors.darkerNightBlue,
          ),
          child: Material(
            elevation: 20,
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }
}
