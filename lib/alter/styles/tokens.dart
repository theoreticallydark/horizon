import 'package:flutter/material.dart';
import 'swatches.dart';

/// Alter Design System Semantic Theme Tokens
abstract class AlterSemanticTokens {
  // Text Tokens
  static const Color textPrimary = AlterColors.black;
  static const Color textSecondary = AlterColors.colorsGray600;
  static const Color textDisabled = AlterColors.colorsGray400;
  static const Color textInverse = AlterColors.white;
  static const Color textCaution = AlterColors.colorsYellow600;
  static const Color textWarning = AlterColors.colorsOrange600;
  static const Color textDanger = AlterColors.colorsRed600;
  static const Color textSuccess = AlterColors.colorsGreen600;

  // Status Tokens
  static const Color statusSuccess = AlterColors.colorsGreen600;
  static const Color statusSuccessContrast = AlterColors.white;
  static const Color statusTeal = AlterColors.colorsTeal600;
  static const Color statusTealContrast = AlterColors.white;
  static const Color statusWarning = AlterColors.colorsOrange600;
  static const Color statusWarningContrast = AlterColors.white;

  // Base Surface Tokens
  static const Color baseGray = AlterColors.colorsGray050;
  static const Color baseWhite = AlterColors.white;
  static const Color baseBlack = AlterColors.colorsGray800;

  // Stroke Tokens
  static const Color stroke100 = AlterColors.colorsGray100;
  static const Color stroke200 = AlterColors.colorsGray200;
  static const Color stroke1000 = AlterColors.black;

  // UI Element Tokens
  static const Color ui1 = AlterColors.colorsGray100;
  static const Color ui2 = AlterColors.colorsGray200;
  static const Color ui4 = AlterColors.colorsGray400;
  static const Color ui6 = AlterColors.colorsGray600;
}