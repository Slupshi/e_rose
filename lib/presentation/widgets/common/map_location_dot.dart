import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapLocationDotWidget extends StatelessWidget {
  final String tooltip;
  final String? iconCode;
  final String? iconFontFamily;
  final String? iconFontPackage;
  final Color color;
  const MapLocationDotWidget({
    super.key,
    required this.tooltip,
    this.iconCode,
    this.iconFontFamily,
    this.iconFontPackage,
    this.color = CustomColors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textAlign: TextAlign.center,
      message: tooltip,
      child: FaIcon(
        iconCode != null
            ? IconData(
                int.parse(iconCode!),
                fontFamily: iconFontFamily,
                fontPackage: iconFontPackage,
              )
            : FontAwesomeIcons.locationDot,
        color: color,
        size: iconCode != null ? 30 : null,
      ),
    );
  }
}
