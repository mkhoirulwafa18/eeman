import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';

class AppTextStyle {
  TextStyle inputLabel = TextStyle(
    color: AppColors().backgroundColor.withOpacity(0.7),
    fontFamily: 'Poppins',
    fontSize: 12,
  );

  TextStyle inputText = TextStyle(
    color: AppColors().backgroundColor,
    fontFamily: 'Poppins',
    fontSize: 14,
  );

  TextStyle lightBoldTitle = TextStyle(
    color: AppColors().backgroundColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  TextStyle largeText = TextStyle(
    color: AppColors().backgroundColor,
    fontFamily: 'Poppins',
    fontSize: 24,
  );

  TextStyle smallText = TextStyle(
    color: AppColors().backgroundColor,
    fontFamily: 'Poppins',
    fontSize: 12,
  );
}
