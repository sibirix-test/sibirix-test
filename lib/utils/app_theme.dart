import 'package:flutter/material.dart';
import 'package:fwitter/utils/globals.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  colorScheme: _colorScheme,
  appBarTheme: const AppBarTheme(
    elevation: 0.3,
    color: AppColors.background,
  ),
  dividerColor: Colors.black,
  textTheme: GoogleFonts.ralewayTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
);

final _colorScheme = ColorScheme(
  primary: AppColors.primary,
  primaryContainer: AppColors.primary.withOpacity(0.5),
  secondary: AppColors.secondary,
  secondaryContainer: AppColors.secondary.withOpacity(0.5),
  surface: Colors.white,
  background: AppColors.background,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: const Color.fromARGB(255, 255, 255, 255),
  onSurface: const Color.fromARGB(255, 60, 60, 60),
  onBackground: const Color.fromARGB(255, 93, 93, 93),
  onError: Colors.red,
  brightness: Brightness.light,
);
