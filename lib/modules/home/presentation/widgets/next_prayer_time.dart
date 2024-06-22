import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';

class NextPrayerTime extends StatelessWidget {
  const NextPrayerTime({super.key, required this.currentHour});
  final String currentHour;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final todayTimings = state.todayTiming;
          final tomorrowTimings = state.tomorrowTiming;
          final timeDiff = _calculateTimeDiff(context, todayTimings, tomorrowTimings ?? []);
          return Text(
            timeDiff,
            style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            context.l10n.dontForgetPray,
            style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
          );
        }
      },
    );
  }

  // Calculate the time difference between the current time and the next prayer time
  String _calculateTimeDiff(
    BuildContext context,
    List<Pray> todayTimings,
    List<Pray> tomorrowTimings,
  ) {
    final format = DateFormat('HH:mm');
    final start = format.parse(currentHour);
    var end = DateTime.now(); // * Default Value to [DateTime.now()]
    var timeDiff = '';

    // Calculate the time difference for today's prayer times
    for (var i = 0; i < todayTimings.length; i++) {
      final time = todayTimings[i];
      end = format.parse(time.time.split(' ')[0]);
      final diff = end.difference(start);
      final hours = diff.inHours != 0 ? '${diff.inHours} ${context.l10n.hour}' : '';
      final minutes = (diff.inMinutes % 60) != 0 ? '${diff.inMinutes % 60} ${context.l10n.minute}' : '';
      final to = '${context.l10n.to} ${time.name}';

      if (end.isAfter(start)) {
        timeDiff = '$hours $minutes $to';
        break;
      }
    }

    // If no prayer time is found for today, calculate the time difference for tomorrow's prayer times
    if (timeDiff.isEmpty) {
      final tomorrowLT = format
          .parse(
            tomorrowTimings[0].time.split(' ')[0],
          )
          .add(const Duration(days: 1))
          .difference(start);
      timeDiff =
          '${tomorrowLT.inHours} ${context.l10n.hour} ${tomorrowLT.inMinutes % 60} ${context.l10n.minute} ${context.l10n.to} ${tomorrowTimings[0].name}';
    }

    return timeDiff.trim();
  }
}
