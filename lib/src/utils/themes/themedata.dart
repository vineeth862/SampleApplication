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
      tertiary: Color.fromARGB(225, 81, 174, 128),
      surface: Colors.white,
      inverseSurface: Color.fromARGB(255, 102, 102, 102),
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
    headlineLarge: GoogleFonts.robotoSlab(
        fontSize: 21, color: Color.fromARGB(255, 32, 32, 32)),
    headlineMedium: GoogleFonts.robotoSlab(
        fontSize: 16, color: Color.fromARGB(255, 32, 32, 32)),
    headlineSmall: GoogleFonts.robotoSlab(
        fontSize: 12, color: Color.fromARGB(255, 32, 32, 32)),
    bodyMedium: GoogleFonts.notoSans(
        fontSize: 10, color: Color.fromARGB(255, 90, 89, 89)),
    bodyLarge: GoogleFonts.notoSans(
        fontSize: 12, color: Color.fromARGB(255, 90, 89, 89)),
    titleMedium:
        GoogleFonts.besley(fontSize: 10, color: Color.fromARGB(255, 0, 0, 0)),
  ),
  appBarTheme: AppBarTheme(),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Color.fromARGB(
        225, 21, 209, 230), // Change to your desired button color
  ),
  cardTheme: CardTheme(
    elevation: 2.0,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
