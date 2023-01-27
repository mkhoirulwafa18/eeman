import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    this.appBar,
    this.bgColor,
    required this.child,
  }) : padding = const EdgeInsets.all(16);

  const BasePage.noPadding({
    super.key,
    this.appBar,
    this.bgColor,
    required this.child,
  }) : padding = EdgeInsets.zero;

  final PreferredSizeWidget? appBar;
  final Color? bgColor;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: bgColor ?? backgroundColor,
        body: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
