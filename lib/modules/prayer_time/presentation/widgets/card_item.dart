import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/alarmlist_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/list_filter.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.time,
    required this.title,
    required this.selectedDate,
    required this.active,
  });

  final String time;
  final String title;
  final DateTime selectedDate;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final hour = time;
    final fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(hour.split(':')[0]),
      int.parse(hour.split(':')[1]),
    );
    final isPassed = DateTime.now().compareTo(fullDateTime) == -1;

    return BlocBuilder<AlarmListCubit, List<DateTime>>(
      builder: (context, alarmState) {
        return BlocBuilder<ListFilterPrayerTimeCubit, List<String>>(
          builder: (context, filterState) {
            return Visibility(
              visible: !filterState.contains(title),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isPassed ? backgroundColor2 : backgroundColor2.withOpacity(0.7),
                    boxShadow: isPassed ? [primaryShadow] : [],
                    border: isPassed && active ? Border.all(color: Colors.red, width: 2) : null,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hour,
                                  style: lightBoldTitle.copyWith(
                                    fontSize: 50,
                                    color: isPassed ? backgroundColor : backgroundColor.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  title,
                                  style: mediumText.copyWith(
                                    color: isPassed ? backgroundColor : backgroundColor.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => context.read<AlarmListCubit>().scheduleNotification(
                                    isPassed: isPassed,
                                    selectedDate: fullDateTime,
                                    title: title,
                                  ),
                              child: Icon(
                                isPassed
                                    ? (alarmState.contains(fullDateTime)
                                        ? Icons.alarm_on_rounded
                                        : Icons.alarm_add_rounded)
                                    : Icons.alarm_off_rounded,
                                color: backgroundColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
