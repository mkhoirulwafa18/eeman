import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';

class PrayerTimeHeaderContent extends StatefulWidget {
  const PrayerTimeHeaderContent({super.key, required this.location, required this.city});
  final Location location;
  final String city;
  @override
  State<PrayerTimeHeaderContent> createState() => _PrayerTimeHeaderContentState();
}

class _PrayerTimeHeaderContentState extends State<PrayerTimeHeaderContent> {
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
    final dateCubit = context.read<DatepickerCubit>();
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),
            height: MediaQuery.of(context).size.height / 5 / 1.5,
            width: MediaQuery.of(context).size.height / 5 / 1.8 * 0.9,
            initialSelectedDate: DateTime.now(),
            controller: controller,
            selectionColor: backgroundColor2,
            selectedTextColor: backgroundColor,
            locale: 'id',
            dateTextStyle: largeText.copyWith(
              color: backgroundColor2.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
            monthTextStyle: smallText.copyWith(color: backgroundColor2.withOpacity(0.5)),
            dayTextStyle: smallText.copyWith(color: backgroundColor2.withOpacity(0.5)),
            onDateChange: (date) async {
              controller.animateToDate(date);
              final updatedTimings = await context.read<PrayertimeCubit>().getTimings(date, widget.location);

              await context.read<PrayertimeCubit>().updateTimings(updatedTimings, widget.city);

              dateCubit.onSelectDate(date);
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<PrayertimeCubit, PrayertimeState>(
          builder: (context, state) {
            if (state is PrayertimeLoaded) {
              return Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                  Text(
                    state.city ?? '',
                    style: smallText,
                  ),
                ],
              );
            }
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ],
    );
  }
}
