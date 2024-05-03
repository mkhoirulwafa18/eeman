import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/alarmlist_cubit.dart';
import 'package:quran_app/modules/prayer_time/presentation/widgets/card_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CardList extends StatelessWidget {
  const CardList({super.key, required this.selectedDate, required this.controller, required this.listOfTiming});
  final DateTime selectedDate;
  final ItemScrollController controller;
  final List<Pray> listOfTiming;

  @override
  Widget build(BuildContext context) {
    // Finding Current Hour "index" that has not yet passed the current time
    final firstIndexNotPassed = listOfTiming.indexWhere((element) {
      final h = element.time;
      final fullDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        int.parse(h.split(':')[0]),
        int.parse(h.split(':')[1]),
      );

      return DateTime.now().compareTo(fullDate) == -1;
    });

    // Scroll to Current Hour
    // (only if the items index is higher than 2 to avoid weird animation when current hour is
    //  still visible)
    if (firstIndexNotPassed != -1 && firstIndexNotPassed > 2) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.scrollTo(
          index: firstIndexNotPassed,
          duration: const Duration(milliseconds: 300),
        );
      });
    }

    // Clear all reminder since all hours has been passed
    if (firstIndexNotPassed == 1) {
      context.read<AlarmListCubit>().clearReminder();
    }
    return ScrollablePositionedList.builder(
      itemScrollController: controller,
      shrinkWrap: true,
      itemPositionsListener: ItemPositionsListener.create(),
      itemCount: listOfTiming.length,
      itemBuilder: (context, index) => CardItem(
        time: listOfTiming[index].time,
        title: listOfTiming[index].name,
        selectedDate: selectedDate,
        active: index == firstIndexNotPassed,
      ),
    );
  }
}
