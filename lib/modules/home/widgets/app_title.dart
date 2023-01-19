import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Eeman',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: AppColors().backgroundColor,
      ),
    );
  }
}
