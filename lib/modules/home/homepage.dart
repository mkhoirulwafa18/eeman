// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/models/quran.dart';
import 'package:quran_app/modules/home/services/shared_pref.dart';
import 'package:quran_app/modules/home/widgets/box_header.dart';

import 'package:quran_app/modules/home/widgets/quran_appbar.dart';
import 'package:quran_app/modules/home/widgets/surah_list.dart';
import 'package:quran_app/modules/surah/services/shared_prefs.dart';
import 'package:quran_app/modules/surah/surah_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Quran> _quran = [];
  List<int> ayatOfTheDay = [];
  String _lastHit = '';
  int lastReadSurah = 0;
  int lastReadAyat = 0;

  Future<void> readJson() async {
    final quranResponse = await rootBundle.loadString('assets/sources/quran.json');
    final quranData = quranFromJson(quranResponse);
    setState(() {
      _quran = quranData;
    });
  }

  Future<void> ayatOfTheDayFunc() async {
    final aotd = await _getAyatOfTheDay();
    final lastHit = await Storage.getString('last_hit');
    setState(() {
      ayatOfTheDay = aotd;
      _lastHit = lastHit;
    });
  }

  Future<void> getLastRead() async {
    final surah = await SurahStorage.getInt('last_read_surah');
    final ayat = await SurahStorage.getInt('last_read_ayat');
    setState(() {
      lastReadSurah = surah;
      lastReadAyat = ayat;
    });
  }

  Future<List<int>> _getAyatOfTheDay() async {
    final data = await Storage.getAyatOfTheDay();
    return data;
  }

  void _goToLastRead() {
    getLastRead();
    Navigator.push<MaterialPageRoute<dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => SurahPage(
          noAyat: lastReadSurah,
          dataQuran: _quran,
          startAyat: lastReadAyat,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readJson();
    ayatOfTheDayFunc();
    WidgetsBinding.instance.addObserver(this);
    getLastRead();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check if the day has changed
      final now = DateTime.now();
      final lastHit = DateTime.parse(_lastHit);
      final formatter = DateFormat.yMd();
      if (formatter.format(now) != formatter.format(lastHit)) {
        hitApi();
      }
    }
  }

  void hitApi() {
    Storage.setAyatOfTheDay(_quran);
    ayatOfTheDayFunc();
    Storage.setString('last_hit', DateTime.now().toIso8601String());
  }

  void _onSearch(String key) {
    final temp = <Quran>[];
    temp.addAll(_quran.where((element) => element.name!.contains(key)));
    setState(() {
      _quran = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: QuranAppBar(
        appBar: AppBar(),
        title: l10n.homePageAppBarTitle,
        showBack: false,
      ),
      backgroundColor: const Color(0xff011240),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxHeader(data: _quran, aotd: ayatOfTheDay),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xffE3C3F8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  cursorColor: const Color(0xffE3C3F8),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xffE3C3F8),
                    ),
                    focusColor: Color(0xff011240),
                    border: InputBorder.none,
                    labelText: 'Cari Surah',
                  ),
                  onChanged: _onSearch,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_quran.isNotEmpty)
              SurahList(quran: _quran)
            else
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffE3C3F8),
                  ),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffb9a0ff),
        onPressed: () async {
          _goToLastRead();
        },
        child: SvgPicture.asset(
          'assets/icons/last_read.svg',
          width: 30,
        ),
      ),
    );
  }
}
