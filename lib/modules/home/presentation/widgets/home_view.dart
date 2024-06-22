import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/themes/app_theme.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';
import 'package:quran_app/modules/home/presentation/widgets/widgets.dart';
import 'package:quran_app/modules/prayer_time/prayer_time.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final theme = context.watch<AppThemeCubit>().state;
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            // * App Title
            SliverAppBar(
              backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(l10n.appName, style: context.displayLarge),
              actions: [
                IconButton(
                  onPressed: () => context.read<AppThemeCubit>().toggleTheme(),
                  icon: Icon(theme == ThemeMode.dark ? Icons.nightlight : Icons.sunny),
                ),
                const AppInfoAction(),
              ],
              centerTitle: true,
              pinned: true,
            ),
            // * Header Card (Pinned when Scrolled)
            const SliverAppBar(
              pinned: true,
              collapsedHeight: 160,
              expandedHeight: 170,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Padding(
                padding: EdgeInsets.all(16),
                child: HeaderCard(),
              ),
            ),
            // * Spacing
            const SliverPadding(padding: EdgeInsets.only(bottom: 12)),
            // * Prayer Time Horizontal ListView
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.shalatTime.replaceAll('\n', ' '),
                          style: context.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (state is HomeLoaded) {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => PrayerTimePage(
                                    city: state.currentLocationInCity,
                                    location: state.currentLocation,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                l10n.more,
                                style: context.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrayerTimeListView(),
                ],
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
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Text(
                      l10n.explore,
                      style: context.bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
                    ),
                  ),
                  MenuList(
                    doaDaily: state is HomeLoaded ? state.doaDaily : [],
                    city: state is HomeLoaded ? state.currentLocationInCity : '',
                    location: state is HomeLoaded
                        ? state.currentLocation
                        : Location(latitude: 0, longitude: 0, timestamp: DateTime.now()),
                  ),
                  const SizedBox(
                    height: EemanSizes.s24,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
