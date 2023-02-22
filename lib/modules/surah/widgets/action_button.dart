import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/surah/surah_page.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';

enum ButtonActionType { back, next }

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required int indexSurah,
    required this.dataQuran,
    required this.type,
  }) : _indexSurah = indexSurah;

  final int _indexSurah;
  final List<Quran> dataQuran;
  final ButtonActionType type;

  @override
  Widget build(BuildContext context) {
    return _indexSurah == 144
        ? const SizedBox()
        : SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement<MaterialPageRoute<dynamic>,
                    MaterialPageRoute<dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahPage(
                      noSurah: type == ButtonActionType.back
                          ? (_indexSurah - 1)
                          : (_indexSurah == 114 ? 1 : _indexSurah + 1),
                      dataQuran: dataQuran,
                    ),
                  ),
                );
              },
              icon: Icon(
                type == ButtonActionType.back
                    ? Icons.arrow_back
                    : Icons.arrow_forward,
              ),
              label: Text(
                type == ButtonActionType.back ? 'Kembali' : 'Lanjut',
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor2,
              ),
            ),
          );
  }
}
