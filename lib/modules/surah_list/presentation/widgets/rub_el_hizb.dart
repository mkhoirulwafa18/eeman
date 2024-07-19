// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/gen/assets.gen.dart';

class RubElHizb extends StatelessWidget {
  const RubElHizb({
    super.key,
    required this.number,
    this.color,
  });

  final String number;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Assets.icons.rubhizb.svg(
          width: 40,
          color: color ?? colorScheme.onSurface,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: Align(
            child: Text(
              number,
              style: context.bodyMedium?.copyWith(color: color ?? colorScheme.onSurface, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
