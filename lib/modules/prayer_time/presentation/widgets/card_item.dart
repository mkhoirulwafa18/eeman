import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/services/notifications.dart';
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
    final filterCubit = context.read<ListFilterPrayerTimeCubit>();
    final hour = time;
    final fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(hour.split(':')[0]),
      int.parse(hour.split(':')[1]),
    );
    final isPassed = DateTime.now().compareTo(fullDateTime);

    return BlocBuilder<AlarmListCubit, List<DateTime>>(
      builder: (context, state) {
        return Visibility(
          visible: !filterCubit.state.contains(title),
          child: GestureDetector(
            onTap: () async {
              final permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
              debugPrint(permissionStatus.toString());
              if (permissionStatus == PermissionStatus.unknown || permissionStatus == PermissionStatus.denied) {
                await NotificationPermissions.requestNotificationPermissions();
              }

              if (isPassed == -1) {
                if (state.contains(fullDateTime)) {
                  await context.read<AlarmListCubit>().onRemoveReminder(fullDateTime);
                } else {
                  await context.read<AlarmListCubit>().onAddReminder(fullDateTime);
                }
              }
              await NotificationHelper().scheduledNotification(
                hour: fullDateTime.hour,
                minutes: fullDateTime.minute,
                id: int.parse(hour.split(':').join()),
                title: title,
                sound: 'adzan',
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isPassed == -1 ? backgroundColor2 : backgroundColor2.withOpacity(0.7),
                  boxShadow: isPassed == -1 ? [primaryShadow] : [],
                  border: isPassed == -1 && active ? Border.all(color: Colors.red, width: 2) : null,
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
                                  color: isPassed == -1 ? backgroundColor : backgroundColor.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                title,
                                style: mediumText.copyWith(
                                  color: isPassed == -1 ? backgroundColor : backgroundColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isPassed == -1
                                ? (state.contains(fullDateTime) ? Icons.alarm_on_rounded : Icons.alarm_add_rounded)
                                : Icons.alarm_off_rounded,
                            color: backgroundColor,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
