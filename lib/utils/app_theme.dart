import 'package:flutter/material.dart';

const Color lightPrimaryColor =  Color.fromRGBO(0, 104 , 107, 1);
const Color darkPrimaryColor = Color.fromRGBO(136, 230, 215, 1);

const Color lightSecondaryColor =  Color.fromRGBO(19, 19, 19, 1);
const Color darkSecondaryColor = Color.fromRGBO(249, 255, 254, 1);

const Color lightScaffoldBackgroundColor = Color.fromRGBO(249, 255, 254, 1);
const Color darkScaffoldBackgroundColor = Color.fromRGBO(19, 19, 19, 1);

const Color lightCardColor = Color.fromRGBO(235, 241, 239, 1.0);
const Color darkCardColor = Color.fromRGBO(42, 42, 42, 1.0);

const Color lightIconColor =  Color.fromRGBO(175, 175, 175, 1);
const Color darkIconColor = Color.fromRGBO(104, 104, 104, 1);

/// The light theme configuration for the application.
///
/// Defines colors, text styles, and other visual properties for light mode.
/// Uses [lightPrimaryColor] as the primary color and [lightSecondaryColor]
/// for text and highlights.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  highlightColor: lightSecondaryColor,
  scaffoldBackgroundColor: lightScaffoldBackgroundColor,
  cardColor: lightCardColor,
  disabledColor: lightIconColor,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: lightSecondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: lightSecondaryColor,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: lightSecondaryColor,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: lightIconColor,
      fontSize: 12,
    ),
  ),
  iconTheme: const IconThemeData(
    color: lightIconColor,
    size: 24,
  ),
);

/// The dark theme configuration for the application.
///
/// Defines colors, text styles, and other visual properties for dark mode.
/// Uses [darkPrimaryColor] as the primary color and [darkSecondaryColor]
/// for text and highlights.
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  highlightColor: darkSecondaryColor,
  scaffoldBackgroundColor: darkScaffoldBackgroundColor,
  cardColor: darkCardColor,
  disabledColor: darkIconColor,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: darkSecondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: darkSecondaryColor,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: darkSecondaryColor,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: darkIconColor,
      fontSize: 12,
    ),
  ),
  iconTheme: const IconThemeData(
    color: darkIconColor,
    size: 24,
  ),
);

