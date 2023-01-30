import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.bgColor,
  });

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircularProgressIndicator(
            color: bgColor ?? backgroundColor2,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
