// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/gen/assets.gen.dart';
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
            color: backgroundColor2,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
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
                    color: backgroundColor,
                  ),
                  Column(
                    children: [
                      Text(
                        surah.name?.transliteration?.id ?? '',
                        style: mediumText,
                      ),
                      Text(
                        surah.name?.translation?.id ?? '',
                        style: TextStyle(
                          color: backgroundColor.withOpacity(0.5),
                          fontFamily: 'Poppins',
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
                            color: backgroundColor,
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
                            color: backgroundColor,
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
              const SizedBox(
                height: 12,
              ),
              Text(
                '${surah.revelation?.id?.name} - ${surah.numberOfVerses} ayat',
                style: smallText,
              ),
              if (surah.number != 1) ...[
                const SizedBox(
                  height: 16,
                ),
                Assets.icons.basmalah.svg(
                  width: 0.4.sw,
                  color: backgroundColor,
                ),
              ] else
                const SizedBox(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
