import 'package:flutter/material.dart';

import 'package:quran_app/gen/fonts.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/surah.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';

enum ButtonActionType { back, next }

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.selectedSurah,
    required this.surahList,
    required this.type,
  });

  final Surah selectedSurah;
  final ButtonActionType type;
  final List<Surah> surahList;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return selectedSurah.number == 144
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
                      selectedSurah: type == ButtonActionType.back
                          ? surahList.firstWhere((element) => element.number == (selectedSurah.number! - 1))
                          : surahList.firstWhere((element) => element.number == (selectedSurah.number! + 1)),
                      surahList: surahList,
                    ),
                  ),
                );
              },
              icon: Icon(
                type == ButtonActionType.back ? Icons.arrow_back : Icons.arrow_forward,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: Text(
                type == ButtonActionType.back ? l10n.back : l10n.next,
                style: TextStyle(fontFamily: FontFamily.poppins, color: Theme.of(context).colorScheme.surface),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          );
  }
}
