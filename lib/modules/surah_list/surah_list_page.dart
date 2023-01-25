import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/widgets/input_box.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:quran_app/modules/surah_list/widgets/surah_list_data.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage>
    with WidgetsBindingObserver {
  List<Quran> _dataQuran = [];
  List<Quran> _quran = [];

  Future<void> readJson() async {
    final quranResponse =
        await rootBundle.loadString('assets/sources/quran.json');
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
      appBar: CustomAppBar(
        height: MediaQuery.of(context).size.height / 5,
        title: l10n.surahListPageAppBarTitle,
        showBack: false,
        content: InputBox(
          labelText: l10n.findSurah,
          onChanged: _onSearch,
        ),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            if (_dataQuran.isNotEmpty)
              SurahListData(quran: _quran)
            else
              const AppLoading()
          ],
        ),
      ),
    );
  }
}
