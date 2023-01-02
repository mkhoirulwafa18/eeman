import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/modules/home/widgets/glassmorphism.dart';
import 'package:quran_app/modules/home/widgets/rub_el_hizb.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Glassmorphism(
        blur: 1.2,
        opacity: 0.2,
        radius: 20,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              RubElHizb(title: numberSurah.toString()),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xfffafbfb),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              Text(
                translation,
                style: const TextStyle(
                  color: Color(0xffA4A7D3),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '$revelation - $totalAyat ayat',
                style: const TextStyle(
                  color: Color(0xffA4A7D3),
                  fontFamily: 'Poppins',
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              if (numberSurah != 1)
                SvgPicture.asset(
                  'assets/icons/basmalah.svg',
                  width: MediaQuery.of(context).size.width / 2,
                  // height: 40,
                )
              else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
