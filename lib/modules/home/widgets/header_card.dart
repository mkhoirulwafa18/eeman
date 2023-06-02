import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/utils/transformer.dart';
import 'package:quran_app/modules/prayer_time/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

class HeaderCard extends StatefulWidget {
  const HeaderCard({
    super.key,
  });

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  String _time = Intl.withLocale(
    'id',
    () => DateFormat('EEEE, dd MMM').format(DateTime.now()),
  ).toString();
  String _hourMinute =
      Intl.withLocale('id', () => DateFormat('HH:mm').format(DateTime.now()))
          .toString();

  late Timer _timer;

  void setTimeAndHour(Timer timer) {
    setState(() {
      _time = Intl.withLocale(
        'id',
        () => DateFormat('EEEE, dd MMM').format(DateTime.now()),
      ).toString();
      _hourMinute = Intl.withLocale(
        'id',
        () => DateFormat('HH:mm').format(DateTime.now()),
      ).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), setTimeAndHour);
    context.read<PrayertimeCubit>().getTimings(
          DateTime.now().month.toString(),
          DateTime.now().year.toString(),
        );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: backgroundColor),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_time, style: smallText),
                ),
              ),
              BlocBuilder<PrayertimeCubit, PrayertimeState>(
                builder: (context, state) {
                  if (state is PrayertimeLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: AppLoading(),
                    );
                  }
                  if (state is PrayertimeLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.place_rounded,
                            color: Colors.redAccent,
                            size: 16,
                          ),
                          Text(
                            state.city,
                            style: smallText.copyWith(color: backgroundColor2),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          HourMinute(hourMinute: _hourMinute),
          BlocBuilder<PrayertimeCubit, PrayertimeState>(
            builder: (context, state) {
              if (state is PrayertimeLoaded) {
                final listTimings =
                    state.data.data![DateTime.now().day - 1].timings;
                final tomorrowListTimings = state
                    .data
                    .data![DateTime.now().add(const Duration(days: 1)).day - 1]
                    .timings;
                final todayTimings = fromTimingToList(listTimings ?? Timings());
                final tomorrowTimings =
                    fromTimingToList(tomorrowListTimings ?? Timings());
                var timeDiff = '';
                final format = DateFormat('HH:mm');
                final start = format.parse(_hourMinute);
                var end = DateTime.now();
                final tomorrowLT = format
                    .parse(
                      tomorrowTimings[0]['value'].toString().split(' ')[0],
                    )
                    .add(const Duration(days: 1))
                    .difference(start);
                final tomorrowLastThird =
                    // ignore: lines_longer_than_80_chars
                    '${tomorrowLT.inHours} ${l10n.hour} ${tomorrowLT.inMinutes % 60} ${l10n.minute} ${l10n.to} ${tomorrowTimings[0]['name']}';

                for (var i = 0; i < todayTimings.length; i++) {
                  final time = todayTimings[i];
                  end = format.parse(time['value'].toString().split(' ')[0]);
                  final diff = end.difference(start);
                  final hours =
                      diff.inHours != 0 ? '${diff.inHours} ${l10n.hour}' : '';
                  final minutes = (diff.inMinutes % 60) != 0
                      ? '${diff.inMinutes % 60} ${l10n.minute}'
                      : '';
                  final to = '${l10n.to} ${time['name']}';

                  if (end.isAfter(start)) {
                    timeDiff = '$hours $minutes $to';
                    break;
                  }
                }
                return Text(
                  timeDiff.trim() != '' ? timeDiff : tomorrowLastThird,
                  style: smallText.copyWith(color: backgroundColor2),
                  textAlign: TextAlign.center,
                );
              } else {
                return Text(
                  l10n.dontForgetPray,
                  style: smallText.copyWith(color: backgroundColor2),
                );
              }
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class HourMinute extends StatelessWidget {
  const HourMinute({
    super.key,
    required String hourMinute,
  }) : _hourMinute = hourMinute;

  final String _hourMinute;

  @override
  Widget build(BuildContext context) {
    return Text(
      _hourMinute,
      style: lightBoldTitle.copyWith(color: backgroundColor2, fontSize: 50),
    );
  }
}
