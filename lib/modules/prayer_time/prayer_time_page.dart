import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/widgets/card_list.dart';
import 'package:quran_app/modules/prayer_time/widgets/header_content.dart';

class PrayerTimePage extends StatelessWidget {
  const PrayerTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasePage(
      appBar: CustomAppBar(
        height: MediaQuery.of(context).size.height / 3.5,
        title: l10n.shalatTime,
        content: const PrayerTimeHeaderContent(),
      ),
      child: BlocBuilder<DatepickerCubit, DateTime>(
        builder: (context, state) {
          return CardList(selectedDate: state);
        },
      ),
    );
  }
}
