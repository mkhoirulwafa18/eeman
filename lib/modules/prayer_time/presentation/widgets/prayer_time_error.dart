import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/spacing.dart';
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
            style: context.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const EemanSpacing.vertical8(),
          Text(
            state.message == 'No Internet Connection' ? l10n.featureNeedInternet : '',
            style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const EemanSpacing.vertical8(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface),
            ),
            onPressed: () async {
              final updatedTimings = await context.read<PrayerTimeCubit>().getTiming(selectedDate, location);
              await context.read<PrayerTimeCubit>().updateTimings(updatedTimings, city);
            },
            child: Text(
              l10n.refresh,
              style: context.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
