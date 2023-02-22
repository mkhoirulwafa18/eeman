import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/home_page.dart';
import 'package:quran_app/modules/prayer_time/cubit/datepicker_cubit.dart';
import 'package:quran_app/modules/prayer_time/cubit/prayertime_cubit.dart';
import 'package:quran_app/modules/prayer_time/prayer_time_page.dart';
import 'package:quran_app/modules/surah/surah_page.dart';
import 'package:quran_app/modules/surah_list/surah_list_page.dart';
import 'package:quran_app/modules/tasbih/cubit/counter_cubit.dart';
import 'package:quran_app/modules/tasbih/tasbih_page.dart';
import 'package:quran_app/services/dio.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatepickerCubit>(
          create: (context) => DatepickerCubit(),
        ),
        BlocProvider<PrayertimeCubit>(
          create: (context) => PrayertimeCubit(DioHelper()),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (ctx, child) {
          setupScreenUtil(ctx);
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            ),
          );
        },
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/surah-list': (context) => const SurahListPage(),
          '/surah': (context) => SurahPage(
                noSurah: 0,
                dataQuran: const [],
              ),
          '/prayer-time': (context) => const PrayerTimePage(),
          '/tasbih': (context) => const TasbihPage(),
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
