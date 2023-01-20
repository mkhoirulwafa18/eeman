import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/utils/bottomsheet.dart';
import 'package:quran_app/modules/home/widgets/card_menu.dart';
import 'package:quran_app/modules/surah_list/surah_list_page.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showAppBottomSheet(context);
              },
              child: CardMenu(
                color: AppColors().cardGreyColor,
                icon: SvgPicture.asset('assets/icons/praying-hands.svg'),
                title: l10n.doaSehariHari,
                bg: CirclePosition.doa,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<MaterialPageRoute<dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SurahListPage(),
                  ),
                );
              },
              child: CardMenu(
                color: AppColors().cardPeachColor,
                icon: SvgPicture.asset('assets/icons/al-quran.svg'),
                title: l10n.quranOffline,
                bg: CirclePosition.quran,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/prayer-time');
              },
              child: CardMenu(
                color: AppColors().cardGreenColor,
                icon: Image.asset(
                  'assets/icons/shalat.png',
                  height: 110,
                ),
                title: l10n.shalatTime,
                bg: CirclePosition.shalat,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            GestureDetector(
              child: CardMenu(
                color: AppColors().cardYellowColor,
                icon: SvgPicture.asset('assets/icons/tasbih.svg'),
                title: l10n.tasbihDigital,
                bg: CirclePosition.tasbih,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
