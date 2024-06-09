import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/state/prayertime_state.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),
            height: MediaQuery.of(context).size.height / 5 / 1.5,
            width: MediaQuery.of(context).size.height / 5 / 1.8 * 0.9,
            initialSelectedDate: DateTime.now(),
            controller: controller,
            selectionColor: colorScheme.primary,
            selectedTextColor: colorScheme.secondary,
            locale: 'id',
            dateTextStyle: context.displayLarge!.copyWith(
              color: colorScheme.primary.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
            monthTextStyle: context.bodySmall!.copyWith(color: colorScheme.primary.withOpacity(0.5)),
            dayTextStyle: context.bodySmall!.copyWith(color: colorScheme.primary.withOpacity(0.5)),
            onDateChange: (date) async {
              controller.animateToDate(date);
              final updatedTimings = await context.read<PrayerTimeCubit>().getTiming(date, widget.location);

              await context.read<PrayerTimeCubit>().updateTimings(updatedTimings, widget.city);

              dateCubit.onSelectDate(date);
            },
          ),
        ),
        const EemanSpacing.vertical8(),
        BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
          builder: (context, state) {
            if (state is PrayerTimeLoaded) {
              return Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                  Text(
                    state.currentLocationInCity,
                    style: context.bodySmall?.copyWith(color: colorScheme.secondary),
                  ),
                ],
              );
            }
            return const EemanSpacing.vertical12();
          },
        ),
      ],
    );
  }
}
