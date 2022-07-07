import 'package:flutter/material.dart';
import 'package:fwitter/utils/globals.dart';

final appTheme = ThemeData.from(colorScheme: _colorScheme).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.secondary,
    elevation: 0.0,
  ),
  dividerColor: Colors.black,
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
