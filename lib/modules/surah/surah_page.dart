// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/modules/home/widgets/glassmorphism.dart';
// import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/widgets/quran_appbar.dart';
import 'package:quran_app/modules/home/widgets/rub_el_hizb.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key, required this.noAyat});
  final String noAyat;

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<dynamic> _ayatSurah = [];
  String title = '';
  int numberSurah = 0;
  String translation = '';
  String revelation = '';
  int totalAyat = 0;

  Future<void> readJson() async {
    final surahResponse = await rootBundle.loadString('assets/sources/surahs/${widget.noAyat}.json');
    final surah = json.decode(surahResponse);
    setState(() {
      _ayatSurah = surah['verses'] as List;
      title = surah['name']['transliteration']['id'] as String;
      numberSurah = surah['number'] as int;
      translation = surah['name']['translation']['id'] as String;
      revelation = surah['revelation']['id'] as String;
      totalAyat = surah['numberOfVerses'] as int;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      appBar: QuranAppBar(
        appBar: AppBar(),
        title: title,
      ),
      backgroundColor: const Color(0xff011240),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: _ayatSurah.isNotEmpty
            ? ListView.builder(
                itemCount: _ayatSurah.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // return the header
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
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  index -= 1;
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(16),
                    tileColor: index.isOdd ? const Color.fromARGB(255, 8, 33, 102) : const Color(0xff011240),
                    trailing: RubElHizb(
                      title: (index + 1).toString(),
                    ),
                    title: Text(
                      _ayatSurah[index]['text']['arab'] as String,
                      style: const TextStyle(
                        fontFamily: 'IsepMisbah',
                        fontSize: 20,
                        color: Color(0xffFAFBFB),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    isThreeLine: true,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _ayatSurah[index]['text']['transliteration']['en'] as String,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffFAFBFB),
                          ),
                        ),
                        Text(
                          _ayatSurah[index]['translation']['id'] as String,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffA4A7D3),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
