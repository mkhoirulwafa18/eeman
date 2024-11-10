import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/extensions/time_extension.dart';
import 'package:quran_app/common/themes/app_colors.dart';
import 'package:quran_app/common/widgets/spacing.dart';
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
  Future<void> _initTimer() async {
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
        image: DecorationImage(image: Assets.images.mosque.provider(), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Display date and place
          DateAndPlace(time: _time),

          // Display hour and minute
          Text(
            _hourMinute,
            style: context.displayLarge?.copyWith(color: AppColors.white, fontSize: 50),
          ),

          // Display next prayer time
          NextPrayerTime(
            currentHour: _hourMinute,
          ),
          const EemanSpacing.vertical16(),
        ],
      ),
    );
  }
}
