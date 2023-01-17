import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/modules/surah/surah_page.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:quran_app/modules/surah_list/widgets/rub_el_hizb.dart';

class SurahListData extends StatelessWidget {
  const SurahListData({
    super.key,
    required List<Quran> quran,
  }) : _quran = quran;

  final List<Quran> _quran;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: const Color(0xff011240),
        child: _quran.isNotEmpty
            ? ListView.separated(
                itemCount: _quran.length,
                separatorBuilder: (_, i) => const Divider(
                  color: Color(0xffA4A7D3),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(index, context);
                },
              )
            : const Expanded(
                child: Center(
                  child: Text(
                    'Tidak ada surah yang cocok dengan pencarian.\nCoba ulangi ketik surah yang kamu cari.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),
    );
  }

  ListTile _buildItem(int index, BuildContext context) {
    return ListTile(
      leading: RubElHizb(
        title: _quran[index].numberOfSurah.toString(),
      ),
      title: Text(
        _quran[index].name ?? '',
        style: const TextStyle(
          color: Color(0xffFAFBFB),
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _quran[index].nameTranslations!.id ?? '',
                    style: const TextStyle(
                      color: Color(0xffA4A7D3),
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  if (_quran[index].place == Place.mecca)
                    WidgetSpan(
                      child: SvgPicture.asset(
                        'assets/icons/mecca.svg',
                        width: 12,
                        color: const Color(0xfffafbfb),
                      ),
                    )
                  else
                    WidgetSpan(
                      child: SvgPicture.asset(
                        'assets/icons/medina.svg',
                        width: 16,
                        color: const Color(0xfffafbfb),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      dense: true,
      trailing: Text(
        _quran[index].nameTranslations!.ar ?? '',
        style: const TextStyle(
          color: Color(0xFFB9A0FF),
          fontFamily: 'IsepMisbah',
          fontSize: 20,
        ),
      ),
      onTap: () {
        Navigator.push<MaterialPageRoute<dynamic>>(
          context,
          MaterialPageRoute(
            builder: (context) => SurahPage(
              noAyat: index,
              dataQuran: _quran,
            ),
          ),
        );
      },
    );
  }
}
