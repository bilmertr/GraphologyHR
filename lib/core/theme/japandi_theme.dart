import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'japandi_colors.dart';

class JapandiTheme {
  JapandiTheme._();

  static ThemeData light() {
    final baseText = GoogleFonts.plusJakartaSansTextTheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: JapandiColors.ricePaper,
      cardColor: JapandiColors.cardSurfaceLight,
      colorScheme: const ColorScheme.light(
        primary: JapandiColors.bambooGreen,
        secondary: JapandiColors.brassGold,
        surface: JapandiColors.cardSurfaceLight,
        error: JapandiColors.terracottaClay,
        outline: JapandiColors.hairlineLight,
      ),
      dividerTheme: const DividerThemeData(
        color: JapandiColors.hairlineLight,
        thickness: 0.6,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: JapandiColors.ricePaper,
        foregroundColor: JapandiColors.inkPrimaryLight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: baseText.copyWith(
        displaySmall: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 15.5,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 15,
          height: 1.56,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryLight,
          fontSize: 14,
          height: 1.52,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryLight,
          fontSize: 12.5,
          height: 1.45,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryLight,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryLight,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: JapandiColors.bambooGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: JapandiColors.inkPrimaryLight,
          side: const BorderSide(color: JapandiColors.hairlineLight, width: 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final baseText = GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: JapandiColors.sumiInk,
      cardColor: JapandiColors.charcoalCard,
      colorScheme: const ColorScheme.dark(
        primary: JapandiColors.brassGold,
        secondary: JapandiColors.bambooGreenLight,
        surface: JapandiColors.charcoalCard,
        error: JapandiColors.terracottaClay,
        outline: JapandiColors.hairlineDark,
      ),
      dividerTheme: const DividerThemeData(
        color: JapandiColors.hairlineDark,
        thickness: 0.6,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: JapandiColors.sumiInk,
        foregroundColor: JapandiColors.inkPrimaryDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: baseText.copyWith(
        displaySmall: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.cormorantGaramond(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 15.5,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 15,
          height: 1.56,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkPrimaryDark,
          fontSize: 14,
          height: 1.52,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryDark,
          fontSize: 12.5,
          height: 1.45,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryDark,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          color: JapandiColors.inkSecondaryDark,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: JapandiColors.brassGold,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: JapandiColors.inkPrimaryDark,
          side: const BorderSide(color: JapandiColors.hairlineDark, width: 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
