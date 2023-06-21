import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
  fontFamily: 'Lato',
  colorScheme: const ColorScheme(
    primary: Color.fromRGBO(199, 96, 218, 1), // Light purple color
    primaryContainer: Color(0xFFBA61CA),
    secondary: Color.fromRGBO(206, 147, 216, 1), // Light purple color
    secondaryContainer: Color.fromRGBO(176, 94, 191, 1),
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Color.fromARGB(253, 31, 30, 30),
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
    displayMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
    titleLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
  ),
  appBarTheme: const AppBarTheme(),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.blue, // Change to your desired button color
    disabledColor: Colors.grey, // Change to your desired disabled button color
    minWidth: 120.0,
    height: 48.0,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
);
