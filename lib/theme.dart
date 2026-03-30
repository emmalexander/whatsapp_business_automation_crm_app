import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF10B96B); // approximate
  static const Color secondaryGreen = Color(0xFF1F9E5C);
  static const Color background = Color(0xFFF7F8FA);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF111827);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textLightGrey = Color(0xFF9CA3AF);
  static const Color accentBlue = Color(0xFFE2E9FE); // for the pipeline card
  static const Color warningOrange = Color(0xFFF5A384); // overdue chip
  static const Color greenDot = Color(0xFF10C05C);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: secondaryGreen,
        background: background,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: textDark),
        bodyMedium: GoogleFonts.inter(color: textDark),
        bodySmall: GoogleFonts.inter(color: textGrey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: textDark),
        titleTextStyle: GoogleFonts.inter(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
