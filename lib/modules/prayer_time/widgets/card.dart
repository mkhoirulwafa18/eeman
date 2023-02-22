import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.time,
    required this.title,
    required this.selectedDate,
  });

  final String time;
  final String title;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final hour = time.split(' ')[0];
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
      visible: title != shalats[4],
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
