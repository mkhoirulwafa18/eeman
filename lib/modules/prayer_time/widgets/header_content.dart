import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/stateful_wrapper.dart';
import 'package:quran_app/modules/prayer_time/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/cubit/prayertime_cubit.dart';

class PrayerTimeHeaderContent extends StatelessWidget {
  const PrayerTimeHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DatePickerController();
    final dateCubit = context.read<DatepickerCubit>();
    final halfBackgroundColor2 = backgroundColor2.withOpacity(0.5);
    return StatefulWrapper(
      onInit: () {
        if (DateTime.now().month != dateCubit.previousState?.month) {
          context.read<PrayertimeCubit>().getTimings(
                DateTime.now().month.toString(),
                DateTime.now().year.toString(),
              );
        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          controller.animateToDate(
            DateTime.now(),
            duration: const Duration(seconds: 1),
          );
        });
      },
      child: Column(
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
                color: halfBackgroundColor2,
                fontWeight: FontWeight.w600,
              ),
              monthTextStyle: smallText.copyWith(color: halfBackgroundColor2),
              dayTextStyle: smallText.copyWith(color: halfBackgroundColor2),
              onDateChange: (date) {
                controller.animateToDate(date);

                if (date.month != dateCubit.previousState?.month) {
                  context
                      .read<PrayertimeCubit>()
                      .getTimings(date.month.toString(), date.year.toString());
                } else {
                  context.read<PrayertimeCubit>().getTimings(
                        dateCubit.previousState?.month.toString() ?? '',
                        dateCubit.previousState?.year.toString() ?? '',
                      );
                }
                dateCubit.onSelectDate(date);
                debugPrint('${dateCubit.state}');
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
                      state.city,
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
      ),
    );
  }
}
