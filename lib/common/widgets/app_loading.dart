import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.bgColor,
    this.size,
  });

  final Color? bgColor;
  final int? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size?.toDouble() ?? 20,
        height: size?.toDouble() ?? 20,
        child: CircularProgressIndicator(
          color: bgColor ?? backgroundColor2,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
