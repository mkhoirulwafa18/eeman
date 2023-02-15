import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.time,
    required this.title,
    required this.selectedDate,
  });

  final Timings time;
  final String title;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final hour = title == shalats[0]
        ? time.fajr!.split(' ')[0]
        : title == shalats[1]
            ? time.sunrise!.split(' ')[0]
            : title == shalats[2]
                ? time.dhuhr!.split(' ')[0]
                : title == shalats[3]
                    ? time.asr!.split(' ')[0]
                    : title == shalats[4]
                        ? time.sunset!.split(' ')[0]
                        : title == shalats[5]
                            ? time.maghrib!.split(' ')[0]
                            : title == shalats[6]
                                ? time.isha!.split(' ')[0]
                                : title == shalats[7]
                                    ? time.imsak!.split(' ')[0]
                                    : title == shalats[8]
                                        ? time.midnight!.split(' ')[0]
                                        : title == shalats[9]
                                            ? time.firstthird!.split(' ')[0]
                                            : time.lastthird!.split(' ')[0];
    final isPassed = DateTime.now().compareTo(
      DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        int.parse(hour.split(':')[0]),
        int.parse(hour.split(':')[1]),
      ),
    );
    return Visibility(
      visible: title == shalats[0] ||
          title == shalats[1] ||
          title == shalats[2] ||
          title == shalats[3] ||
          title == shalats[5] ||
          title == shalats[6],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isPassed == -1
                ? backgroundColor2
                : backgroundColor2.withOpacity(0.7),
            boxShadow: isPassed == -1 ? [primaryShadow] : [],
          ),
          child: Column(
            children: [
              SizedBox(
                height: setHeight(200),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hour,
                      style: lightBoldTitle.copyWith(
                        fontSize: 50,
                        color: isPassed == -1
                            ? backgroundColor
                            : backgroundColor.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      title,
                      style: mediumText.copyWith(
                        // fontSize: setFontSize(32),
                        color: isPassed == -1
                            ? backgroundColor
                            : backgroundColor.withOpacity(0.7),
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
  }
}
