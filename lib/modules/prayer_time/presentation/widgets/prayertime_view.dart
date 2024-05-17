// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/state/prayertime_state.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/card_list.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/header_content.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/prayer_time_error.dart';
import 'package:quran_app/modules/prayer_time/utils/filter_dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerTimeView extends StatelessWidget {
  const PrayerTimeView({
    super.key,
    required this.l10n,
    required this.location,
    required this.city,
    required this.controller,
  });

  final AppLocalizations l10n;
  final Location location;
  final String city;
  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatepickerCubit, DateTime>(
      builder: (context, selectedDate) {
        return WillPopScope(
          onWillPop: () {
            context.read<DatepickerCubit>().resetToInitial();
            Navigator.of(context).pop();
            return Future.value(true);
          },
          child: BasePage.noPadding(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                // * App Title
                SliverAppBar(
                  backgroundColor: backgroundColor2,
                  foregroundColor: backgroundColor,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  title: Text(
                    l10n.shalatTime.replaceAll('\n', ' '),
                    style: largeText.copyWith(color: backgroundColor, fontWeight: FontWeight.bold),
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
                  centerTitle: true,
                  pinned: true,
                ),
                // * DatePicker Card (Pinned when Scrolled)
                SliverAppBar(
                  pinned: true,
                  collapsedHeight: MediaQuery.of(context).size.height * 0.17,
                  expandedHeight: MediaQuery.of(context).size.height * 0.17,
                  scrolledUnderElevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: backgroundColor2,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrayerTimeHeaderContent(
                          location: location,
                          city: city,
                        ),
                      ],
                    ),
                  ),
                ),

                // // * Spacing
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),

                SliverToBoxAdapter(
                  child: BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
                    builder: (context, prayerTimeState) {
                      if (prayerTimeState is PrayerTimeInitial || prayerTimeState is PrayerTimeLoading) {
                        return const AppLoading();
                      }
                      if (prayerTimeState is PrayerTimeError) {
                        return PrayerTimeErrorWidget(
                          l10n: l10n,
                          selectedDate: selectedDate,
                          state: prayerTimeState,
                          location: location,
                          city: city,
                        );
                      }
                      if (prayerTimeState is PrayerTimeLoaded) {
                        final listOfTiming = prayerTimeState.currentSelectedTiming;

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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
