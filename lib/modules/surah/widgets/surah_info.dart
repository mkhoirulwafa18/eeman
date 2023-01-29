import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/surah_list/widgets/rub_el_hizb.dart';

class SurahInfo extends StatelessWidget {
  const SurahInfo({
    super.key,
    required this.numberSurah,
    required this.title,
    required this.translation,
    required this.revelation,
    required this.totalAyat,
  });

  final int numberSurah;
  final String title;
  final String translation;
  final String revelation;
  final int totalAyat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor2,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            RubElHizb(
              number: numberSurah.toString(),
              color: backgroundColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: mediumText,
            ),
            Text(
              translation,
              style: TextStyle(
                color: backgroundColor.withOpacity(0.5),
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              '$revelation - $totalAyat ayat',
              style: smallText,
            ),
            if (numberSurah != 1) ...[
              const SizedBox(
                height: 16,
              ),
              SvgPicture.asset(
                '$iconAsset/basmalah.svg',
                width: 0.4.sw,
                color: backgroundColor,
              )
            ] else
              const SizedBox()
          ],
        ),
      ),
    );
  }
}
