// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/gen/assets.gen.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    this.appBar,
    this.accentBackground,
    this.floatingActionButton,
    required this.child,
  }) : padding = const EdgeInsets.symmetric(horizontal: 16);

  const BasePage.noPadding({
    super.key,
    this.appBar,
    this.accentBackground,
    this.floatingActionButton,
    required this.child,
  }) : padding = EdgeInsets.zero;

  final PreferredSizeWidget? appBar;
  final bool? accentBackground;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      extendBodyBehindAppBar: true,
      floatingActionButton: floatingActionButton,
      body: Padding(
        padding: padding,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Assets.icons.bgPattern.svg(color: backgroundColor2.withOpacity(.03), fit: BoxFit.fitHeight),
            ),
            if (accentBackground ?? false) ...[
              Positioned(
                top: -MediaQuery.of(context).size.width / 4,
                right: -MediaQuery.of(context).size.width / 4,
                child: Assets.icons.pattern
                    .svg(color: backgroundColor2.withOpacity(.2), width: MediaQuery.of(context).size.width / 1.3),
              ),
            ],
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
