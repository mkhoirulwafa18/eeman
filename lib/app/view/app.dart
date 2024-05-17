import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/app/view/widgets/custom_feedback.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/presentation/home_page.dart';
import 'package:quran_app/modules/prayer_time/prayer_time.dart';
import 'package:quran_app/modules/qibla/qibla.dart';
import 'package:quran_app/modules/settings/domain/settings_usecase.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';
import 'package:quran_app/modules/settings/settings.dart';
import 'package:quran_app/modules/surah/surah.dart';
import 'package:quran_app/modules/surah_list/data/domain/surah_model.dart';
import 'package:quran_app/modules/surah_list/surah_list.dart';
import 'package:quran_app/modules/tasbih/tasbih_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatepickerCubit>(
          create: (context) => DatepickerCubit(),
        ),
        BlocProvider<AlarmListCubit>(
          create: (context) => AlarmListCubit(locator<AlarmListLocalData>())..init(),
        ),
        BlocProvider<ListFilterPrayerTimeCubit>(
          create: (context) => ListFilterPrayerTimeCubit(locator<PrayerTimeFilterListLocalData>())..init(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(locator<SettingsUseCaseImpl>())..init(),
        ),
      ],
      child: BetterFeedback(
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
        ),
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
