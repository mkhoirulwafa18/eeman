import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerTimeListView extends StatelessWidget {
  PrayerTimeListView({super.key});

  final images = <SvgPicture>[
    Assets.icons.subuh.svg(height: 90),
    Assets.icons.sunrise.svg(height: 90),
    Assets.icons.dzuhur.svg(height: 90),
    Assets.icons.ashar.svg(height: 90),
    Assets.icons.maghrib.svg(height: 90),
    Assets.icons.isya.svg(height: 90),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Skeletonizer(
            enabled: state is HomeLoading,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, top: 5),
              itemCount: state is HomeLoaded ? state.todayTiming.length : 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                            child: images[index],
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: Text(
                              state is HomeLoaded ? state.todayTiming[index].time : '00:00',
                              style: context.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        state is HomeLoaded ? state.todayTiming[index].name.replaceAll(' ', '\n') : '',
                        style:
                            context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
