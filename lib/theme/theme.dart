import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myTheme {
    static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(bodyMedium: GoogleFonts.quicksand(color: Colors.white)),
  );
   static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(bodyMedium: GoogleFonts.quicksand()),
  );

}