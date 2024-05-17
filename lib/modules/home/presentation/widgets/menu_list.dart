import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/domain/menu_item.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';
import 'package:quran_app/modules/home/presentation/widgets/grid_item.dart';
import 'package:quran_app/modules/home/utils/bottomsheet.dart';
import 'package:quran_app/modules/prayer_time/prayer_time.dart';
import 'package:quran_app/modules/qibla/presentation/qibla_page.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.doaDaily, required this.location, required this.city});
  final List<DoaDaily> doaDaily;
  final Location location;
  final String city;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <GridItem>[
          GridItem(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) => QiblaPage(location: location)),
            ),
            item: MenuItem(
              title: 'Arah\nKiblat',
              icon: Assets.icons.compassPng.image(width: 50, height: 50),
              bgColor: cardYellowColor,
            ),
          ),
          GridItem(
            onTap: () => Navigator.pushNamed(context, '/surah-list'),
            item: MenuItem(
              title: l10n.quranOffline,
              icon: Assets.icons.alQuran.svg(width: 30, height: 50),
              bgColor: cardPeachColor,
            ),
          ),
          GridItem(
            onTap: () => Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PrayerTimePage(
                  city: city,
                  location: location,
                ),
              ),
            ),
            item: MenuItem(
              title: l10n.shalatTime,
              icon: Assets.icons.shalatPng.image(width: 50, height: 50),
              bgColor: cardGreenColor,
            ),
          ),
          GridItem(
            onTap: () => Navigator.pushNamed(context, '/tasbih'),
            item: MenuItem(
              title: l10n.tasbihDigital,
              icon: Assets.icons.tasbih.svg(width: 50, height: 50),
              bgColor: cardYellowColor,
            ),
          ),
          GridItem(
            onTap: () => showAppBottomSheet(context, doaDaily),
            item: MenuItem(
              title: l10n.doaSehariHari,
              icon: Assets.icons.prayingHands.svg(width: 50, height: 50),
              bgColor: cardGreyColor,
            ),
          ),
          GridItem(
            onTap: () => Navigator.pushNamed(context, '/settings'),
            item: MenuItem(
              title: 'Pengaturan',
              icon: Assets.icons.setting.image(width: 50, height: 50),
              bgColor: cardYellowColor,
            ),
          ),
        ],
      ),
    );
  }
}
