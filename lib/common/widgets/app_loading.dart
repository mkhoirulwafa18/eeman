import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors().backgroundColor2,
        ),
      ),
    );
  }
}
