import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/models/quran.dart';

import 'package:quran_app/modules/home/widgets/quran_appbar.dart';
import 'package:quran_app/modules/home/widgets/surah_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Quran> _dataQuran = [];
  List<Quran> _quran = [];

  Future<void> readJson() async {
    final quranResponse = await rootBundle.loadString('assets/sources/quran.json');
    final quranData = quranFromJson(quranResponse);
    setState(() {
      _dataQuran = quranData;
      _quran = quranData;
    });
  }

  void _onSearch(String key) {
    final keyword = key.toLowerCase().replaceAll(RegExp("[^0-9a-zA-Z']"), '');
    if (keyword == '') {
      setState(() {
        _quran = _dataQuran;
      });
    } else {
      setState(() {
        _quran = _dataQuran
            .where(
              (element) => element.name!
                  .toLowerCase()
                  .replaceAll(
                    RegExp("[^0-9a-zA-Z']"),
                    '',
                  )
                  .contains(keyword),
            )
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
                  style: const TextStyle(color: Colors.white),
                  onChanged: _onSearch,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_dataQuran.isNotEmpty) SurahList(quran: _quran) else const AppLoading()
          ],
        ),
      ),
    );
  }
}
