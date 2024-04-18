import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/surah/cubit/surah_info_cubit.dart';

void showTafsirBottomSheet(
  BuildContext context,
  SurahInfoLoaded state,
  int index,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final l10n = context.l10n;
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ColoredBox(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            builder: (_, controller) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          l10n.tafsirBottomSheetTitle(
                            state.title,
                            (index + 1).toString(),
                          ),
                          style: largeText.copyWith(
                            color: backgroundColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.tafsirSource,
                          style: smallText.copyWith(color: backgroundColor2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Text(
                        //   (index == 0 && state.numberSurah != 1
                        //           ? state.ayatSurah[index].text!.substring(39)
                        //           : state.ayatSurah[index].text) ??
                        //       '',
                        //   style: arabicText,
                        //   textAlign: TextAlign.right,
                        //   textDirection: TextDirection.rtl,
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Text(
                        //   state.tafsirSurah.id!.kemenag
                        //           ?.text!['${index + 1}'] ??
                        //       '',
                        //   style: inputLabel.copyWith(color: backgroundColor2),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
