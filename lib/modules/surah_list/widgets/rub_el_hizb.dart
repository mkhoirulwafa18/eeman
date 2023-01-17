import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RubElHizb extends StatelessWidget {
  const RubElHizb({
    super.key,
    required this.title,
    this.color,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/rubhizb.svg',
          width: 40,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: Align(
            child: Text(
              title,
              style: TextStyle(
                color: color ?? const Color(0xffFAFBFB),
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
