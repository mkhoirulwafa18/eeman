import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/extensions/time_extension.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/modules/home/presentation/widgets/date_and_place.dart';
import 'package:quran_app/modules/home/presentation/widgets/next_prayer_time.dart';

class HeaderCard extends StatefulWidget {
  const HeaderCard({super.key});

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  // Timer to update the current time every minute
  late Timer _timer;

  // Current time and hour-minute strings
  String _time = DateTime.now().toLocalAndFormat('EEEE, dd MMM');
  String _hourMinute = DateTime.now().toLocalAndFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Initialize the timer to update the current time every minute
  void _initTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(_updateCurrentTime);
    });
  }

  // Update the current time and hour-minute strings
  void _updateCurrentTime() {
    _time = DateTime.now().toLocalAndFormat('EEEE, dd MMM');
    _hourMinute = DateTime.now().toLocalAndFormat('HH:mm');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.15,
      decoration: BoxDecoration(
        image: DecorationImage(image: Assets.icons.mosque.provider(), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Display date and place
          DateAndPlace(time: _time),

          // Display hour and minute
          Text(
            _hourMinute,
            style: lightBoldTitle.copyWith(color: backgroundColor, fontSize: 50),
          ),

          // Display next prayer time
          NextPrayerTime(
            currentHour: _hourMinute,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
