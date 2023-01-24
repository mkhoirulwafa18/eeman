import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';

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
        SvgPicture.asset(
          'assets/icons/rubhizb.svg',
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
                fontFamily: 'IsepMisbah',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
