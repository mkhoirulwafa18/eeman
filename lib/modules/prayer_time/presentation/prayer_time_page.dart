import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_usecase.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/prayertime_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({super.key, required this.location, required this.city});
  final Location location;
  final String city;
  final controller = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => PrayerTimeCubit(locator<PrayerTimeUseCaseImpl>())..init(DateTime.now(), location, city),
      child: PrayerTimeView(l10n: l10n, location: location, city: city, controller: controller),
    );
  }
}
