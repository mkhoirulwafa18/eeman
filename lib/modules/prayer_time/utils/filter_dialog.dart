// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
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
      final colorScheme = Theme.of(context).colorScheme;
      return AlertDialog(
        backgroundColor: colorScheme.primary,
        title: Text(
          l10n.filterList,
          style: context.displayLarge?.copyWith(color: colorScheme.secondary),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: shalats
                  .map(
                    (e) => CheckboxListTile(
                      title: Text(e, style: context.bodySmall?.copyWith(color: colorScheme.secondary)),
                      onChanged: (value) {
                        if (value != null) {
                          !value
                              ? context.read<ListFilterPrayerTimeCubit>().onAddHiddenPray(e)
                              : context.read<ListFilterPrayerTimeCubit>().onRemoveHiddenPray(e);
                        }
                      },
                      value: !state.contains(e),
                      fillColor: MaterialStatePropertyAll(colorScheme.secondary),
                      checkColor: colorScheme.primary,
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
              style: context.bodySmall?.copyWith(color: colorScheme.secondary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              l10n.apply,
              style: context.bodySmall?.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      );
    },
  );
}
