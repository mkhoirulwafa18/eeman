import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';
import 'package:quran_app/modules/settings/presentation/blocs/state/settings_state.dart';

void showPreferencesDialog(
  BuildContext context,
  TextEditingController controller,
  int totalAyat,
) {
  final l10n = context.l10n;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: backgroundColor2,
            title: Text(
              'Atur tampilan',
              style: lightBoldTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tampilkan terjemahan',
                      style: smallText,
                    ),
                    Switch.adaptive(
                      value: state.userPreferences?.showTranslation ?? true,
                      activeColor: backgroundColor,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setPreferences(
                              state.userPreferences?.copyWith(showTranslation: value) ?? const UserPreferences(),
                            );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tampilkan transliteration',
                      style: smallText,
                    ),
                    Switch.adaptive(
                      value: state.userPreferences?.showLatin ?? true,
                      activeColor: backgroundColor,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setPreferences(
                              state.userPreferences?.copyWith(showLatin: value) ?? const UserPreferences(),
                            );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ukuran Font Arabic',
                      style: smallText,
                    ),
                    Text(
                      state.userPreferences?.arabicFontSize?.toStringAsFixed(0) ?? '',
                      style: smallText,
                    ),
                  ],
                ),
                Slider.adaptive(
                  min: 22,
                  max: 32,
                  divisions: 10,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  // label: state.userPreferences?.arabicFontSize.toString(),
                  value: state.userPreferences?.arabicFontSize ?? 24,
                  activeColor: backgroundColor,
                  secondaryActiveColor: backgroundColor2,

                  onChanged: (value) {
                    context.read<SettingsCubit>().setPreferences(
                          state.userPreferences?.copyWith(arabicFontSize: value) ?? const UserPreferences(),
                        );
                  },
                ),
              ],
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
            ],
          );
        },
      );
    },
  );
}
