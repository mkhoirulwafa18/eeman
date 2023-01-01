// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/widgets/box_header.dart';

import 'package:quran_app/modules/home/widgets/quran_appbar.dart';
import 'package:quran_app/modules/home/widgets/rub_el_hizb.dart';
import 'package:quran_app/modules/surah/surah_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  List<dynamic> _surahs = [];
  List<dynamic> _juz = [];

  Future<void> readJson() async {
    final surahsResponse = await rootBundle.loadString('assets/sources/surah.json');
    final juzResponse = await rootBundle.loadString('assets/sources/juz.json');
    final surahList = json.decode(surahsResponse);
    final juzList = json.decode(juzResponse);
    setState(() {
      _surahs = surahList as List;
      _juz = juzList as List;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              const BoxHeader(),
              const SizedBox(
                height: 20,
              ),
              _buildTabs(l10n),
              const SizedBox(
                height: 16,
              ),
              if (_surahs.isNotEmpty && _juz.isNotEmpty)
                Expanded(
                  child: TabBarView(
                    children: [
                      ColoredBox(
                        color: const Color(0xff011240),
                        child: ListView.separated(
                          itemCount: _surahs.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Color(0xffA4A7D3),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: RubElHizb(
                                title: (index + 1).toString(),
                              ),
                              title: Text(
                                _surahs[index]['name'] as String,
                                style: const TextStyle(
                                  color: Color(0xffFAFBFB),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _surahs[index]['name_translations']['id'] as String,
                                    style: const TextStyle(
                                      color: Color(0xffA4A7D3),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (_surahs[index]['place'] == 'Mecca')
                                    SvgPicture.asset(
                                      'assets/icons/mecca.svg',
                                      width: 16,
                                      color: const Color(0xfffafbfb),
                                    )
                                  else
                                    SvgPicture.asset(
                                      'assets/icons/medina.svg',
                                      width: 16,
                                      color: const Color(0xfffafbfb),
                                    ),
                                ],
                              ),
                              dense: true,
                              trailing: Text(
                                _surahs[index]['name_translations']['ar'] as String,
                                style: const TextStyle(
                                  color: Color(0xFFB9A0FF),
                                  fontFamily: 'IsepMisbah',
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurahPage(
                                      noAyat: (index + 1).toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      ColoredBox(
                        color: const Color(0xff011240),
                        child: ListView.separated(
                          itemCount: _juz.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Color(0xffA4A7D3),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              trailing: RubElHizb(
                                title: (index + 1).toString(),
                              ),
                              title: Text(
                                '${l10n.tabBarJuzLabel} ${_juz[index]['index'] as String}',
                                style: const TextStyle(color: Color(0xffFAFBFB), fontSize: 16),
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_juz[index]['start']['name'] as String} (${(_juz[index]['start']['verse'] as String).split('_')[1]}) - ',
                                    style: const TextStyle(
                                      color: Color(0xffA4A7D3),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
                                    '${_juz[index]['end']['name'] as String} (${(_juz[index]['end']['verse'] as String).split('_')[1]})',
                                    style: const TextStyle(
                                      color: Color(0xffA4A7D3),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              dense: true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
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
      ),
    );
  }

  SizedBox _buildTabs(AppLocalizations l10n) {
    return SizedBox(
      height: 50,
      child: AppBar(
        backgroundColor: const Color(0xff011240),
        elevation: 0,
        flexibleSpace: TabBar(
          indicatorColor: const Color(0xffE3C3F8),
          indicatorWeight: 3,
          tabs: [
            Tab(
              child: Text(
                l10n.tabBarSurahLabel,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Tab(
              child: Text(
                l10n.tabBarJuzLabel,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
