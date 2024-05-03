import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';
import 'package:quran_app/modules/home/presentation/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            // * App Title
            SliverAppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                l10n.appName,
                style: lightBoldTitle.copyWith(color: backgroundColor2),
              ),
              actions: [AppInfoAction(l10n: l10n)],
              centerTitle: true,
              // pinned: true,
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
                          'Jadwal Sholat',
                          style: inputLabel.copyWith(color: backgroundColor2, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/prayer-time'),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'more',
                                style: smallText.copyWith(color: backgroundColor2),
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
                      'Eksplor',
                      style: inputLabel.copyWith(color: backgroundColor2, fontWeight: FontWeight.bold),
                    ),
                  ),
                  MenuList(doaDaily: state is HomeLoaded ? state.doaDaily : []),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
