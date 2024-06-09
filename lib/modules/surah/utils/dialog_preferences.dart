import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/themes/app_theme.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';
import 'package:quran_app/modules/settings/presentation/blocs/state/settings_state.dart';

void showPreferencesDialog(
  BuildContext context,
  TextEditingController controller,
  int totalAyat,
) {
  final l10n = context.l10n;
  final colorScheme = Theme.of(context).colorScheme;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: colorScheme.primary,
            title: Text(
              l10n.setAppearance,
              style: context.displayLarge?.copyWith(color: colorScheme.secondary),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.nightMode,
                      style: context.bodySmall?.copyWith(color: colorScheme.secondary),
                    ),
                    Switch.adaptive(
                      value: context.watch<AppThemeCubit>().state == ThemeMode.dark,
                      activeTrackColor: colorScheme.secondary,
                      activeColor: colorScheme.primary,
                      activeThumbImage: Assets.icons.mosque.provider(),
                      onChanged: (value) {
                        context.read<AppThemeCubit>().toggleTheme();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.showX('Translation'),
                      style: context.bodySmall?.copyWith(color: colorScheme.secondary),
                    ),
                    Switch.adaptive(
                      value: state.userPreferences?.showTranslation ?? true,
                      activeTrackColor: colorScheme.secondary,
                      activeColor: colorScheme.primary,
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
                      l10n.showX('Latin'),
                      style: context.bodySmall?.copyWith(color: colorScheme.secondary),
                    ),
                    Switch.adaptive(
                      value: state.userPreferences?.showLatin ?? true,
                      activeTrackColor: colorScheme.secondary,
                      activeColor: colorScheme.primary,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setPreferences(
                              state.userPreferences?.copyWith(showLatin: value) ?? const UserPreferences(),
                            );
                      },
                    ),
                  ],
                ),
                const EemanSpacing.vertical12(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.xFontSize('Arabic'),
                      style: context.bodySmall?.copyWith(color: colorScheme.secondary),
                    ),
                    Text(
                      state.userPreferences?.arabicFontSize?.toStringAsFixed(0) ?? '',
                      style: context.bodySmall?.copyWith(color: colorScheme.secondary),
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
                  activeColor: colorScheme.secondary,
                  secondaryActiveColor: Theme.of(context).colorScheme.primary,

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
                  style: context.bodySmall?.copyWith(color: colorScheme.secondary),
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
