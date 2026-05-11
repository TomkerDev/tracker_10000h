import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const darkBlue = Color(0xFF070D1A);
  static const accentCyan = Color(0xFF22D3EE);
  static const cardGrey = Color(0xFF111827);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBlue,
    primaryColor: accentCyan,
    textTheme: GoogleFonts.syneTextTheme(ThemeData.dark().textTheme),
    // Style pour les textes secondaires
    secondaryHeaderColor: GoogleFonts.dmSans().color,
  );
}