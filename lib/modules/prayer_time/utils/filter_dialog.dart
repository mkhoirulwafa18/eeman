// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/cubit/list_filter.dart';

void showFilterPrayerTimeDialog(
  BuildContext context,
) {
  final l10n = context.l10n;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final state = context.watch<ListFilterPrayerTimeCubit>().state;
      return AlertDialog(
        backgroundColor: backgroundColor2,
        title: Text(
          l10n.filterList,
          style: lightBoldTitle,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: shalats
                  .map(
                    (e) => CheckboxListTile(
                      title: Text(e, style: smallText),
                      onChanged: (value) {
                        if (value != null) {
                          !value
                              ? context.read<ListFilterPrayerTimeCubit>().onAddFilters(e)
                              : context.read<ListFilterPrayerTimeCubit>().onRemoveFilters(e);
                        }
                      },
                      value: !state.contains(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            child: Text(
              l10n.close,
              style: smallText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              l10n.apply,
              style: smallText.copyWith(color: backgroundColor2),
            ),
          ),
        ],
      );
    },
  );
}
