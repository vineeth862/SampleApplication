import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  colorScheme: const ColorScheme(
      //primary: Color.fromRGBO(176, 113, 187, 1), // Light purple color
      //primary: Color.fromRGBO(235, 93, 22, 0.984),

      primary: Color.fromRGBO(189, 73, 50, 1),
      primaryContainer: Color.fromRGBO(189, 73, 50, 1),
      secondary: Color.fromRGBO(219, 229, 233, 1),
      //secondaryContainer: Color.fromRGBO(253, 247, 247, 1),
      secondaryContainer: Color.fromRGBO(251, 245, 243, 1),
      tertiary: Color.fromRGBO(177, 75, 55, 1),
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Color.fromARGB(253, 31, 30, 30),
      onError: Colors.white,
      brightness: Brightness.light,
      outlineVariant: Colors.orangeAccent),
  textTheme: TextTheme(
    headlineMedium: GoogleFonts.robotoSlab(
        fontSize: 16, color: Color.fromARGB(255, 32, 32, 32)),
    bodyMedium: GoogleFonts.notoSans(
        fontSize: 10, color: Color.fromARGB(255, 90, 89, 89)),
    bodyLarge: GoogleFonts.notoSans(
        fontSize: 12, color: Color.fromARGB(255, 90, 89, 89)),
    titleMedium:
        GoogleFonts.besley(fontSize: 10, color: Color.fromARGB(255, 0, 0, 0)),
    displayLarge: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Colors.black87),
    displayMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color.fromARGB(255, 94, 90, 90),
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
    ),
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color.fromARGB(255, 94, 90, 90),
    ),
    labelMedium: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color.fromARGB(255, 94, 90, 90),
    ),
    labelSmall: TextStyle(
      fontSize: 8.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      color: Color.fromARGB(255, 94, 90, 90),
    ),
  ),
  appBarTheme: const AppBarTheme(),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: const Color.fromRGBO(
        176, 113, 187, 1), // Change to your desired button color
    disabledColor: Colors.grey, // Change to your desired disabled button color
    minWidth: 120.0,
    height: 48.0,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
  cardTheme: CardTheme(
    elevation: 2.0,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
