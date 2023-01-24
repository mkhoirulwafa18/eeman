import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
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
    final l10n = context.l10n;
    return Expanded(
      child: ColoredBox(
        color: backgroundColor,
        child: _quran.isNotEmpty
            ? ListView.separated(
                itemCount: _quran.length,
                separatorBuilder: (_, i) => Divider(
                  color: backgroundColor2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(index, context);
                },
              )
            : Expanded(
                child: Center(
                  child: Text(
                    l10n.errorNoSurahFound,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: backgroundColor2,
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
        number: _quran[index].numberOfSurah.toString(),
      ),
      title: Text(
        _quran[index].name ?? '',
        style: mediumText.copyWith(
          color: backgroundColor2,
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
                    style: mediumText.copyWith(
                      color: backgroundColor2.withOpacity(0.7),
                      fontSize: setFontSize(24),
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
                        color: backgroundColor2,
                      ),
                    )
                  else
                    WidgetSpan(
                      child: SvgPicture.asset(
                        'assets/icons/medina.svg',
                        width: 16,
                        color: backgroundColor2,
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
        style: arabicText,
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
