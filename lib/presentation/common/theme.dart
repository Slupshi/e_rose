import 'package:e_rose/presentation/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData _themeFactory() => ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          const TextTheme(
            bodyMedium: TextStyle(
              color: CustomColors.white,
              fontSize: 11,
            ),
            labelLarge: TextStyle(
              color: CustomColors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  static final ThemeData themeDark = _themeFactory();
}
