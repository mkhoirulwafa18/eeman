import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/modules/surah/surah_page.dart';

enum ButtonActionType { back, next }

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required int indexSurah,
    required this.widget,
    required this.type,
  }) : _indexSurah = indexSurah;

  final int _indexSurah;
  final SurahPage widget;
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
                      noAyat: type == ButtonActionType.back
                          ? (_indexSurah - 1)
                          : (_indexSurah == 114 ? 1 : _indexSurah + 1),
                      dataQuran: widget.dataQuran,
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
                backgroundColor: AppColors().backgroundColor2,
              ),
            ),
          );
  }
}
