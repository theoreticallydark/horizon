import 'package:flutter/material.dart';

/// Alter Design System Typography Tokens
abstract class AlterTypography {
  static const String geistFont = 'Geist';
  static const String instrumentSerifFont = 'InstrumentSerif';

  // Display Styles
  static const TextStyle displayXl = TextStyle(
    fontFamily: geistFont,
    fontSize: 56,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );

  static const TextStyle displayLg = TextStyle(
    fontFamily: geistFont,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    height: 1.375,
  );

  static const TextStyle display = TextStyle(
    fontFamily: geistFont,
    fontSize: 40,
    fontWeight: FontWeight.w400,
    height: 1.300,
  );

  static const TextStyle displayBold = TextStyle(
    fontFamily: geistFont,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.300,
  );

  // Serif Accent Style
  static const TextStyle h1Serif = TextStyle(
    fontFamily: instrumentSerifFont,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 32 / 24,
  );

  // Heading Styles
  static const TextStyle h1Bold = TextStyle(
    fontFamily: geistFont,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 36 / 30,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: geistFont,
    fontSize: 30,
    fontWeight: FontWeight.w400,
    height: 36 / 30,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: geistFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 24 / 20,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: geistFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: geistFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
  );

  static const TextStyle h4Bold = TextStyle(
    fontFamily: geistFont,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 20 / 16,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: geistFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 16 / 14,
  );

  static const TextStyle h5Bold = TextStyle(
    fontFamily: geistFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 16 / 14,
  );

  // Body Styles
  static const TextStyle bodyLg = TextStyle(
    fontFamily: geistFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 20 / 16,
  );

  static const TextStyle bodyLgBold = TextStyle(
    fontFamily: geistFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
  );

  static const TextStyle body = TextStyle(
    fontFamily: geistFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 16 / 14,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: geistFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 16 / 14,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: geistFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
  );

  static const TextStyle captionBold = TextStyle(
    fontFamily: geistFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
  );
}
