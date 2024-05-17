import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/state/prayertime_state.dart';

class PrayerTimeErrorWidget extends StatelessWidget {
  const PrayerTimeErrorWidget({
    super.key,
    required this.l10n,
    required this.selectedDate,
    required this.state,
    required this.location,
    required this.city,
  });

  final AppLocalizations l10n;
  final DateTime selectedDate;
  final PrayerTimeError state;
  final Location location;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message == 'No Internet Connection' ? l10n.noInternetConnection : state.message,
            style: mediumText.copyWith(
              color: backgroundColor2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            state.message == 'No Internet Connection' ? l10n.featureNeedInternet : '',
            style: smallText.copyWith(color: backgroundColor2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(backgroundColor2),
            ),
            onPressed: () async {
              final updatedTimings = await context.read<PrayerTimeCubit>().getTiming(selectedDate, location);
              await context.read<PrayerTimeCubit>().updateTimings(updatedTimings, city);
            },
            child: Text(
              l10n.refresh,
              style: smallText,
            ),
          ),
        ],
      ),
    );
  }
}
