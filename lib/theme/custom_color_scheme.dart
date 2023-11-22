import 'package:flutter/material.dart';

class CustomColorScheme extends ColorScheme {
  static const Color customPrimaryColor = Color(0xFFC45C23);
  static const Color customSecondaryColor = Color(0xFFFDD856);
  static const Color customOnPrimary = Color(0xFFFFFFFF);
  static const Color customOnSecondary = Color(0xFF000000);
  static const Color customError = Color(0xFFFF0000);
  static const Color customOnError = Color(0xFF000000);
  static const Color customBackground = Color(0xFFF9F4E3);
  static const Color customOnBackground = Color(0x66FDD856);
  static const Color customSurface = Color(0x33C45C23);
  static const Color customOnSurface = Color(0xFFD9D9D9);

  const CustomColorScheme(
      {Color primary = customPrimaryColor,
      Color secondary = customSecondaryColor,
      Color onPrimary = customOnPrimary,
      Color onSecondary = customOnSecondary,
      Color error = customError,
      Color onError = customOnError,
      Color background = customBackground,
      Color onBackground = customOnBackground,
      Color surface = customSurface,
      Color onSurface = customOnSurface})
      : super(
            brightness: Brightness.light,
            primary: primary,
            secondary: secondary,
            onPrimary: onPrimary,
            onSecondary: onSecondary,
            error: error,
            onError: onError,
            background: customBackground,
            onBackground: onBackground,
            surface: surface,
            onSurface: onSurface);
}
