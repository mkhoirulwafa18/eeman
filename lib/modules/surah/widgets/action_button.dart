import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/surah_page.dart';

enum ButtonActionType { back, next }

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required int indexSurah,
    required this.dataQuran,
    required this.type,
  }) : _indexSurah = indexSurah;

  final int _indexSurah;
  final List dataQuran;
  final ButtonActionType type;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _indexSurah == 144
        ? const SizedBox()
        : SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement<MaterialPageRoute<dynamic>, MaterialPageRoute<dynamic>>(
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
                type == ButtonActionType.back ? Icons.arrow_back : Icons.arrow_forward,
                color: backgroundColor,
              ),
              label: Text(
                type == ButtonActionType.back ? l10n.back : l10n.next,
                style: TextStyle(fontFamily: 'Poppins', color: backgroundColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor2,
              ),
            ),
          );
  }
}
