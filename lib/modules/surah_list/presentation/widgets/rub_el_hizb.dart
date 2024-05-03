// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
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
    return Stack(
      children: [
        Assets.icons.rubhizb.svg(
          width: 40,
          color: color ?? backgroundColor2,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: Align(
            child: Text(
              number,
              style: TextStyle(
                color: color ?? backgroundColor2,
                fontFamily: 'isepMisbah',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
