import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';

class DateAndPlace extends StatelessWidget {
  const DateAndPlace({
    super.key,
    required String time,
  }) : _time = time;

  final String _time;

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _time,
              style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        if (homeState is HomeInitial || homeState is HomeLoading) ...[
          const Padding(
            padding: EdgeInsets.all(8),
            child: AppLoading(size: 16),
          ),
        ],
        if (homeState is HomeLoaded) ...[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.place_rounded,
                  color: Colors.redAccent,
                  size: 16,
                ),
                Text(
                  homeState.currentLocationInCity,
                  style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
