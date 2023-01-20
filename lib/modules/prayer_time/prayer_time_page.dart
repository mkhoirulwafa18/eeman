import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/common/constants/text_styles.dart';
import 'package:quran_app/modules/prayer_time/widgets/card.dart';
import 'package:quran_app/modules/surah_list/widgets/quran_appbar.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  DateTime _selectedValue = DateTime.now();
  final controller = DatePickerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateToDate(
        DateTime.now(),
        duration: const Duration(seconds: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.animateToSelection,
      ),
      appBar: QuranAppBar(
        height: MediaQuery.of(context).size.height / 5,
        title: 'Jadwal Shalat',
        content: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors().backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),
            height: MediaQuery.of(context).size.height / 5 / 1.8,
            width: MediaQuery.of(context).size.height / 5 / 1.8 * 0.7,
            initialSelectedDate: DateTime.now(),
            controller: controller,
            selectionColor: AppColors().backgroundColor2,
            selectedTextColor: AppColors().backgroundColor,
            locale: 'id',
            daysCount: 31,
            dateTextStyle: AppTextStyle().largeText.copyWith(
                  color: AppColors().backgroundColor2.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
            monthTextStyle: AppTextStyle()
                .smallText
                .copyWith(color: AppColors().backgroundColor2.withOpacity(0.5)),
            dayTextStyle: AppTextStyle()
                .smallText
                .copyWith(color: AppColors().backgroundColor2.withOpacity(0.5)),
            onDateChange: (date) {
              // New date selected
              controller.animateToDate(date);
              setState(() {
                _selectedValue = date;
              });
            },
          ),
        ),
      ),
      backgroundColor: AppColors().backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              ),
              CardItem(
                time: '20:12',
                title: 'Isya',
              )
            ],
          ),
        ),
      ),
    );
  }
}
