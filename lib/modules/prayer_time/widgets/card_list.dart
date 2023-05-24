import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/stateful_wrapper.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/utils/transformer.dart';
import 'package:quran_app/modules/prayer_time/cubit/alarmlist_cubit.dart';
import 'package:quran_app/modules/prayer_time/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';
import 'package:quran_app/modules/prayer_time/widgets/card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CardList extends StatelessWidget {
  CardList({super.key, required this.selectedDate});
  final DateTime selectedDate;

  final controller = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    final dateCubit = context.read<DatepickerCubit>();
    final l10n = context.l10n;
    return StatefulWrapper(
      onInit: () {
        context.read<PrayertimeCubit>().getTimings(
              selectedDate.month.toString(),
              selectedDate.year.toString(),
            );
      },
      child: BlocBuilder<PrayertimeCubit, PrayertimeState>(
        builder: (context, state) {
          if (state is PrayertimeLoading) {
            return const AppLoading();
          }
          if (state is PrayertimeLoaded) {
            if (dateCubit.state.month != selectedDate.month) {
              context.read<PrayertimeCubit>().getTimings(
                    selectedDate.month.toString(),
                    selectedDate.year.toString(),
                  );
            }
            final listTimings = state.data.data;
            final todayTimings = fromTimingToList(
              listTimings?[selectedDate.day - 1].timings ?? Timings(),
            );
            // ignore: cascade_invocations
            final firstIndexNotPassed = todayTimings.indexWhere((element) {
              final h = element['value'].toString().split(' ')[0];
              final fullDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                int.parse(h.split(':')[0]),
                int.parse(h.split(':')[1]),
              );

              return DateTime.now().compareTo(fullDate) == -1;
            });

            if (firstIndexNotPassed != -1 && firstIndexNotPassed > 2) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                controller.scrollTo(
                  index: firstIndexNotPassed,
                  duration: const Duration(milliseconds: 300),
                );
              });
            }
            if (firstIndexNotPassed == 1) {
              context.read<AlarmListCubit>().clearReminder();
            }
            return ScrollablePositionedList.builder(
              itemScrollController: controller,
              shrinkWrap: true,
              itemPositionsListener: ItemPositionsListener.create(),
              itemCount: todayTimings.length,
              itemBuilder: (context, index) => CardItem(
                time: todayTimings[index]['value'].toString(),
                title: todayTimings[index]['name'].toString(),
                selectedDate: selectedDate,
              ),
            );
          }
          if (state is PrayertimeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error == 'No Internet Connection'
                        ? l10n.noInternetConnection
                        : state.error,
                    style: mediumText.copyWith(
                      color: backgroundColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.error == 'No Internet Connection'
                        ? l10n.featureNeedInternet
                        : '',
                    style: smallText.copyWith(color: backgroundColor2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(backgroundColor2),
                    ),
                    onPressed: () => context.read<PrayertimeCubit>().getTimings(
                          selectedDate.month.toString(),
                          selectedDate.year.toString(),
                        ),
                    child: Text(
                      l10n.refresh,
                      style: smallText,
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
