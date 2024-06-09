import 'package:flutter/material.dart';

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
          color: bgColor ?? Theme.of(context).colorScheme.onBackground,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
