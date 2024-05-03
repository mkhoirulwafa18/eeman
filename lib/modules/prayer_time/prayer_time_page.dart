import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/card_list.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/header_content.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/prayer_time_error.dart';
import 'package:quran_app/modules/prayer_time/utils/filter_dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({super.key, required this.location, required this.city});
  final Location location;
  final String city;
  final controller = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<DatepickerCubit, DateTime>(
      builder: (context, selectedDate) {
        return BasePage(
          appBar: CustomAppBar(
            height: MediaQuery.of(context).size.height / 3.5,
            onBackTapped: () {
              context.read<DatepickerCubit>().resetToInitial();
              Navigator.of(context).pop();
            },
            title: l10n.shalatTime,
            content: PrayerTimeHeaderContent(
              location: location,
              city: city,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // ignore: inference_failure_on_function_invocation
                  showFilterPrayerTimeDialog(context);
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: backgroundColor,
                ),
              ),
            ],
          ),
          child: BlocBuilder<PrayertimeCubit, PrayertimeState>(
            builder: (context, prayerTimeState) {
              if (prayerTimeState is PrayertimeInitial) {
                return const AppLoading();
              }
              if (prayerTimeState is PrayertimeError) {
                return PrayerTimeErrorWidget(
                  l10n: l10n,
                  selectedDate: selectedDate,
                  state: prayerTimeState,
                  location: location,
                  city: city,
                );
              }
              if (prayerTimeState is PrayertimeLoaded) {
                final dateCubit = context.read<DatepickerCubit>().state;
                // If the month selected is not the same as the fetched timings month,
                // re fetch data from API with the selected month
                if (dateCubit.month != selectedDate.month) {
                  // context.read<PrayertimeCubit>().getTimings(
                  //       selectedDate.month.toString(),
                  //       selectedDate.year.toString(),
                  //     );
                  log('trueminttt');
                }
                final listOfTiming = prayerTimeState.listOfTiming;

                return CardList(
                  controller: controller,
                  listOfTiming: listOfTiming,
                  selectedDate: selectedDate,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
