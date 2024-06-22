import 'package:flutter/material.dart';
import 'package:quran_app/gen/fonts.gen.dart';

class AppTextStyles {
  static const String fontFamily = FontFamily.poppins;

  /// Body text styles
  static const TextStyle bodyLg = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  static const TextStyle bodyXs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  /// Heading text styles
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  /// Label text styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  /// Arabic text styles
  static const TextStyle arabicText = TextStyle(
    fontFamily: FontFamily.isepMisbah,
    fontSize: 24,
    height: 2,
  );
}
