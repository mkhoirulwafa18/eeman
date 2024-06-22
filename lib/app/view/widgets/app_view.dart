import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/app/view/widgets/custom_feedback.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/themes/app_theme.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/presentation/home_page.dart';
import 'package:quran_app/modules/prayer_time/presentation/prayer_time_page.dart';
import 'package:quran_app/modules/qibla/presentation/qibla_page.dart';
import 'package:quran_app/modules/settings/presentation/settings_page.dart';
import 'package:quran_app/modules/surah/presentation/surah_page.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/presentation/surah_list_page.dart';
import 'package:quran_app/modules/tasbih/tasbih_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      theme: FeedbackThemeData(
        feedbackSheetColor: Colors.grey[50]!,
        drawColors: [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ],
      ),
      feedbackBuilder: (context, onSubmit, scrollController) => CustomFeedbackForm(
        onSubmit: onSubmit,
        scrollController: scrollController,
      ),
      pixelRatio: 1,
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (ctx, child) {
              setupScreenUtil(ctx);
              return MediaQuery(
                data: MediaQuery.of(ctx).copyWith(textScaler: TextScaler.noScaling),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: child!,
                ),
              );
            },
            navigatorKey: rootNavigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/surah-list': (context) => const SurahListPage(),
              '/surah': (context) => SurahPage(
                    selectedSurah: Surah(),
                    surahList: const [],
                  ),
              '/prayer-time': (context) => PrayerTimePage(
                    location: Location(
                      latitude: 0,
                      longitude: 0,
                      timestamp: DateTime.now(),
                    ),
                    city: '',
                  ),
              '/tasbih': (context) => const TasbihPage(),
              '/settings': (context) => const SettingsPage(),
              '/qibla': (context) => QiblaPage(
                    location: Location(
                      latitude: 0,
                      longitude: 0,
                      timestamp: DateTime.now(),
                    ),
                  ),
            },
          );
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
