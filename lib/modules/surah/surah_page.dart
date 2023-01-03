// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:quran_app/modules/home/models/quran.dart';
import 'package:quran_app/modules/home/widgets/quran_appbar.dart';
import 'package:quran_app/modules/home/widgets/rub_el_hizb.dart';
import 'package:quran_app/modules/surah/services/shared_prefs.dart';
import 'package:quran_app/modules/surah/widgets/surah_info.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({
    super.key,
    required this.noAyat,
    required this.dataQuran,
    this.startAyat = 0,
  });
  final int noAyat;
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

  Future<void> getLastReadHere() async {
    final lastAyat = await SurahStorage.getInt('last_read_ayat');
    setState(() {
      lastReadAyat = lastAyat;
    });
  }

  Future<void> readJson() async {
    final data = widget.dataQuran;
    setState(() {
      _indexSurah = widget.noAyat;
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
    getLastReadHere();
    readJson();
    if (widget.startAyat != 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollToIndex(widget.startAyat ?? 0);
      });
    }
  }

  Future<void> scrollToIndex(int index) {
    return controller.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1000),
    );
  }

  Future<void> _setLastRead(int index, int noSurah) async {
    final currentLastReadAyat = await SurahStorage.getInt('last_read_ayat');
    final currentLastReadSurah = await SurahStorage.getInt('last_read_surah');
    if (currentLastReadAyat != (index + 1) || currentLastReadSurah != (noSurah - 1)) {
      await SurahStorage.setInt('last_read_ayat', index + 1);
      await SurahStorage.setInt('last_read_surah', noSurah - 1);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuranAppBar(
        appBar: AppBar(),
        title: title,
      ),
      backgroundColor: const Color(0xff011240),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: _ayatSurah.isNotEmpty
            ? ScrollablePositionedList.builder(
                itemScrollController: controller,
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
                      ? GestureDetector(
                          onTap: () async {
                            await _setLastRead(index, numberSurah);
                          },
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.all(16),
                            tileColor: index.isOdd ? Color.fromARGB(255, 4, 23, 77) : const Color(0xff011240),
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
                                    style: const TextStyle(
                                      fontFamily: 'IsepMisbah',
                                      fontSize: 22,
                                      color: Color(0xffFAFBFB),
                                      height: 2,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: RubElHizb(
                                      title: (index + 1).toString(),
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
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffA4A7D3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement<MaterialPageRoute<dynamic>, MaterialPageRoute<dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahPage(
                                    noAyat: _indexSurah + 1,
                                    dataQuran: widget.dataQuran,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text(
                              'Lanjut',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffb9a0ff),
                            ),
                          ),
                        );
                },
              )
            : const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffE3C3F8),
                  ),
                ),
              ),
      ),
    );
  }
}
