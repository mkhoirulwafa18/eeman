import 'package:flutter_svg/flutter_svg.dart';

class PrayingTime {
  const PrayingTime({
    required this.name,
    required this.image,
    required this.time,
  });
  final String name;
  final SvgPicture image;
  final String time;
}
