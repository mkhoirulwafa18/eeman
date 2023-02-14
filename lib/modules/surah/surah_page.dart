import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/modules/surah/widgets/action_button.dart';
import 'package:quran_app/modules/surah/widgets/surah_info.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:quran_app/modules/surah_list/widgets/rub_el_hizb.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({
    super.key,
    required this.noSurah,
    required this.dataQuran,
    this.startAyat = 0,
  });
  final int noSurah;
  final List<Quran> dataQuran;
  final int? startAyat;
  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<Verse> _ayatSurah = [];
  int _indexSurah = 0;
  String title = '';
  int numberSurah = 0;
  String translation = '';
  Type revelation = Type.MAKKIYAH;
  int totalAyat = 0;
  int lastReadAyat = 0;

  Future<void> initialState() async {
    final data = widget.dataQuran;
    setState(() {
      _indexSurah = widget.noSurah;
      _ayatSurah = data[_indexSurah].verses ?? [];
      title = data[_indexSurah].name ?? '';
      numberSurah = data[_indexSurah].numberOfSurah ?? 0;
      translation = data[_indexSurah].nameTranslations!.id ?? '';
      revelation = data[_indexSurah].type ?? Type.MAKKIYAH;
      totalAyat = data[_indexSurah].numberOfAyah ?? 0;
    });
  }

  final controller = ItemScrollController();
  @override
  void initState() {
    super.initState();
    initialState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage.noPadding(
      appBar: CustomAppBar(title: title),
      child: _ayatSurah.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ScrollablePositionedList.builder(
                itemScrollController: controller,
                shrinkWrap: true,
                itemPositionsListener: ItemPositionsListener.create(),
                itemCount: _ayatSurah.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SurahInfo(
                      numberSurah: numberSurah,
                      title: title,
                      translation: translation,
                      revelation: revelation.name,
                      totalAyat: totalAyat,
                    );
                  }
                  index -= 1;
                  return _ayatSurah.length != index
                      ? _buildItem(index)
                      : _buildFooter();
                },
              ),
            )
          : const AppLoading(),
    );
  }

  Padding _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (numberSurah != 1)
            ActionButton(
              type: ButtonActionType.back,
              indexSurah: _indexSurah,
              widget: widget,
            )
          else
            const SizedBox(),
          if (numberSurah != 114)
            ActionButton(
              indexSurah: _indexSurah,
              widget: widget,
              type: ButtonActionType.next,
            )
          else
            const SizedBox()
        ],
      ),
    );
  }

  ListTile _buildItem(int index) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(16),
      tileColor: index.isEven ? backgroundColor : backgroundColorAlter,
      title: RichText(
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            TextSpan(
              text: (index == 0 && numberSurah != 1
                      ? _ayatSurah[index].text!.substring(39)
                      : _ayatSurah[index].text) ??
                  '',
              style: arabicText,
            ),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RubElHizb(
                  number: (index + 1).toString(),
                ),
              ),
            )
          ],
        ),
      ),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            _ayatSurah[index].translationId ?? '',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: backgroundColor2,
            ),
          ),
        ],
      ),
    );
  }
}
