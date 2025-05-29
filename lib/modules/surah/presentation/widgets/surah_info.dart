// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/gen/fonts.gen.dart';
import 'package:quran_app/modules/surah/presentation/blocs/cubit/murattal_cubit.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/rub_el_hizb.dart';

class SurahInfo extends StatelessWidget {
  const SurahInfo({
    super.key,
    required this.surah,
  });

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return WillPopScope(
      onWillPop: () {
        context.read<MurattalCubit>().dispose();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.5),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RubElHizb(
                    number: surah.number.toString(),
                    color: colorScheme.secondary,
                  ),
                  Column(
                    children: [
                      Text(
                        surah.name?.transliteration?.id ?? '',
                        style: context.bodyMedium?.copyWith(color: colorScheme.secondary),
                      ),
                      Text(
                        surah.name?.translation?.id ?? '',
                        style: TextStyle(
                          color: colorScheme.secondary.withValues(alpha:0.5),
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<MurattalCubit, MurattalState>(
                    builder: (context, state) {
                      if (state is MurattalPlaying) {
                        return GestureDetector(
                          onTap: () {
                            context.read<MurattalCubit>().pause(context);
                          },
                          child: Icon(
                            Icons.pause,
                            color: colorScheme.secondary,
                            size: 40,
                          ),
                        );
                      }
                      if (state is MurattalLoaded || state is MurattalPaused) {
                        return GestureDetector(
                          onTap: () {
                            context.read<MurattalCubit>().play(context);
                          },
                          child: Icon(
                            Icons.play_circle,
                            color: colorScheme.secondary,
                            size: 40,
                          ),
                        );
                      } else {
                        return const AppLoading();
                      }
                    },
                  ),
                ],
              ),
              const EemanSpacing.vertical12(),
              Text(
                '${surah.revelation?.id?.name} - ${surah.numberOfVerses} ayat',
                style: context.bodySmall?.copyWith(color: colorScheme.secondary),
              ),
              if (surah.number != 1) ...[
                const EemanSpacing.vertical16(),
                Assets.icons.basmalah.svg(
                  width: 0.4.sw,
                  color: colorScheme.secondary,
                ),
              ] else
                const SizedBox(),
              const EemanSpacing.vertical16(),
            ],
          ),
        ),
      ),
    );
  }
}
