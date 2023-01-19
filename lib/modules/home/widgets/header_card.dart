import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/common/constants/app_colors.dart';

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
    () => DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
  ).toString();
  String _hourMinute =
      Intl.withLocale('id', () => DateFormat('HH:mm').format(DateTime.now()))
          .toString();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _time = Intl.withLocale(
          'id',
          () => DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
        ).toString();
        _hourMinute = Intl.withLocale(
          'id',
          () => DateFormat('HH:mm').format(DateTime.now()),
        ).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        color: AppColors().backgroundColor,
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
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors().backgroundColor2,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                _time,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: AppColors().backgroundColor,
                ),
              ),
            ),
          ),
          HourMinute(hourMinute: _hourMinute),
          Text(
            '2 jam 20 menit menuju Ashar',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors().backgroundColor2,
            ),
          ),
          const SizedBox(
            height: 24,
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
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 64,
        color: AppColors().backgroundColor2,
      ),
    );
  }
}
