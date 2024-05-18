import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/gen/assets.gen.dart';

class CompassDivider extends StatelessWidget {
  const CompassDivider({super.key, this.linesColor, this.compassColor});

  final Color? linesColor;
  final Color? compassColor;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 2000);
    Widget buildHzAnimatedDivider({bool alignLeft = false}) {
      return TweenAnimationBuilder<double>(
        duration: duration,
        tween: Tween(begin: 0, end: 1),
        curve: Curves.easeOut,
        child: Divider(height: 1, thickness: .5, color: linesColor ?? backgroundColor),
        builder: (_, value, child) {
          return Transform.scale(
            scaleX: value,
            alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: child,
          );
        },
      );
    }

    return Row(
      children: [
        Expanded(child: buildHzAnimatedDivider()),
        const EemanSpacing.vertical8(),
        TweenAnimationBuilder<double>(
          duration: duration,
          tween: Tween(begin: 0, end: .5),
          curve: Curves.easeOutBack,
          builder: (_, value, child) => Transform.rotate(
            angle: value * pi * 2,
            child: child,
          ),
          child: SizedBox(
            height: 32,
            width: 32,
            child: Assets.icons.compassFull.svg(
              colorFilter: ColorFilter.mode(compassColor ?? backgroundColor, BlendMode.srcIn),
            ),
          ),
        ),
        const EemanSpacing.vertical8(),
        Expanded(child: buildHzAnimatedDivider(alignLeft: true)),
      ],
    );
  }
}
