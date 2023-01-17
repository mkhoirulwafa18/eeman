import 'package:flutter/material.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:quran_app/modules/surah_list/widgets/glassmorphism.dart';

class BoxHeader extends StatelessWidget {
  const BoxHeader({
    super.key,
    required this.data,
    required this.aotd,
  });

  final List<Quran> data;
  final List<int> aotd;

  @override
  Widget build(BuildContext context) {
    final surahNo = aotd.isNotEmpty ? aotd[0] : 1;
    final ayatNo = aotd.isNotEmpty ? aotd[1] : 1;
    return data.isNotEmpty
        ? GestureDetector(
            onTap: () {
              // showModalBottomSheet(context: context, builder: (){
              //   return ,
              // },);
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: const Color(0xff011240),
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      Glassmorphism(
                        blur: 8,
                        opacity: 0.1,
                        radius: 20,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                data[surahNo].verses?[ayatNo].text ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'IsepMisbah',
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '"${data[surahNo].verses?[ayatNo].translationId}"',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                '"${data[surahNo].name} - $ayatNo"',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Glassmorphism(
              blur: 8,
              opacity: 0.1,
              radius: 20,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Ayat Hari ini',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
