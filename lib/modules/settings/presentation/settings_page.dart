// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/widgets/divider.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/settings/domain/settings_usecase.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';
import 'package:quran_app/modules/settings/presentation/blocs/state/settings_state.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => SettingsCubit(locator<SettingsUseCaseImpl>())..init(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return BasePage.noPadding(
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
                    l10n.settings,
                    style: largeText.copyWith(color: backgroundColor, fontWeight: FontWeight.bold),
                  ),
                  // actions: [AppInfoAction(l10n: l10n)],
                  centerTitle: true,
                  pinned: true,
                ),
                // * Header Card (Pinned when Scrolled)
                SliverAppBar(
                  pinned: true,
                  collapsedHeight: MediaQuery.of(context).size.height * 0.25,
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  scrolledUnderElevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: backgroundColor2,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          title: RichText(
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'اَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙ',
                                  style: arabicText.copyWith(
                                    color: backgroundColor,
                                    fontSize: state.userPreferences?.arabicFontSize,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: RubElHizb(
                                      number: '2',
                                      color: backgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const EemanSpacing.vertical16(),
                              Visibility(
                                visible: state.userPreferences?.showLatin ?? true,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "al-ḥamdu lillāhi rabbil-'ālamīn",
                                        style: TextStyle(
                                          color: backgroundColor,
                                          fontSize: state.userPreferences?.latinFontSize,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const EemanSpacing.vertical8(),
                              Visibility(
                                visible: state.userPreferences?.showTranslation ?? true,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Segala puji bagi Allah, Tuhan seluruh alam,',
                                        style: smallText.copyWith(
                                          color: backgroundColor,
                                          fontSize: state.userPreferences?.translationFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // * Spacing
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                // * Menu on GridView
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Arabic',
                          style: inputLabel.copyWith(color: backgroundColor2, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        // contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        title: Text(l10n.xFontSize('Arabic')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider.adaptive(
                              min: 22,
                              max: 32,
                              divisions: 10,
                              allowedInteraction: SliderInteraction.tapAndSlide,
                              label: state.userPreferences?.arabicFontSize.toString(),
                              value: state.userPreferences?.arabicFontSize ?? 24,
                              activeColor: backgroundColor2,
                              onChanged: (value) {
                                context.read<SettingsCubit>().setPreferences(
                                      state.userPreferences?.copyWith(arabicFontSize: value) ?? const UserPreferences(),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                SliverToBoxAdapter(
                  child: CompassDivider(
                    compassColor: backgroundColor2,
                    linesColor: backgroundColor2,
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                // * Menu on GridView
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Latin',
                          style: inputLabel.copyWith(color: backgroundColor2, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        // contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        title: Text(l10n.showX('Latin')),
                        trailing: Switch.adaptive(
                          value: state.userPreferences?.showLatin ?? true,
                          activeColor: backgroundColor2,
                          onChanged: (value) {
                            context.read<SettingsCubit>().setPreferences(
                                  state.userPreferences?.copyWith(showLatin: value) ?? const UserPreferences(),
                                );
                          },
                        ),
                      ),
                      ListTile(
                        dense: true,
                        // contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        title: Text(l10n.xFontSize('Latin')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider.adaptive(
                              min: 10,
                              max: 20,
                              divisions: 10,
                              allowedInteraction: SliderInteraction.tapAndSlide,
                              label: state.userPreferences?.latinFontSize.toString(),
                              value: state.userPreferences?.latinFontSize ?? 12,
                              activeColor: backgroundColor2,
                              onChanged: (value) {
                                context.read<SettingsCubit>().setPreferences(
                                      state.userPreferences?.copyWith(latinFontSize: value) ?? const UserPreferences(),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                SliverToBoxAdapter(
                  child: CompassDivider(
                    compassColor: backgroundColor2,
                    linesColor: backgroundColor2,
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                // * Menu on GridView
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Terjemahan',
                          style: inputLabel.copyWith(color: backgroundColor2, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        // contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        title: Text(l10n.showX('Translation')),
                        trailing: Switch.adaptive(
                          value: state.userPreferences?.showTranslation ?? true,
                          activeColor: backgroundColor2,
                          onChanged: (value) {
                            context.read<SettingsCubit>().setPreferences(
                                  state.userPreferences?.copyWith(showTranslation: value) ?? const UserPreferences(),
                                );
                          },
                        ),
                      ),
                      ListTile(
                        dense: true,
                        // contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        title: Text(l10n.xFontSize('Translation')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider.adaptive(
                              min: 10,
                              max: 20,
                              divisions: 10,
                              allowedInteraction: SliderInteraction.tapAndSlide,
                              label: state.userPreferences?.translationFontSize.toString(),
                              value: state.userPreferences?.translationFontSize ?? 12,
                              activeColor: backgroundColor2,
                              onChanged: (value) {
                                context.read<SettingsCubit>().setPreferences(
                                      state.userPreferences?.copyWith(translationFontSize: value) ??
                                          const UserPreferences(),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
