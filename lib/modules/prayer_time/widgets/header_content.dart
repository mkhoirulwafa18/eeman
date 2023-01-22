import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/common/constants/text_styles.dart';
import 'package:quran_app/common/widgets/stateful_wrapper.dart';
import 'package:quran_app/modules/prayer_time/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/cubit/prayertime_cubit.dart';

class PrayerTimeHeaderContent extends StatelessWidget {
  const PrayerTimeHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DatePickerController();
    final dateCubit = context.read<DatepickerCubit>();
    final halfBackgroundColor2 = AppColors().backgroundColor2.withOpacity(0.5);
    return StatefulWrapper(
      onInit: () {
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
              dateTextStyle: AppTextStyle().largeText.copyWith(
                    color: halfBackgroundColor2,
                    fontWeight: FontWeight.w600,
                  ),
              monthTextStyle: AppTextStyle()
                  .smallText
                  .copyWith(color: halfBackgroundColor2),
              dayTextStyle: AppTextStyle()
                  .smallText
                  .copyWith(color: halfBackgroundColor2),
              onDateChange: (date) {
                controller.animateToDate(date);
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
              if (state is PrayertimeLoading) {
                return const SizedBox(
                  height: 10,
                );
              }
              if (state is PrayertimeLoaded) {
                return Row(
                  children: [
                    const Icon(
                      Icons.place_rounded,
                      color: Colors.redAccent,
                    ),
                    Text(
                      state.city,
                      style: AppTextStyle().smallText,
                    )
                  ],
                );
              }
              return Text(state.toString());
            },
          )
        ],
      ),
    );
  }
}
