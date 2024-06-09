// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/gen/fonts.gen.dart';

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
          color: color ?? colorScheme.onBackground,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: Align(
            child: Text(
              number,
              style: TextStyle(
                color: color ?? colorScheme.onBackground,
                fontFamily: FontFamily.isepMisbah,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
