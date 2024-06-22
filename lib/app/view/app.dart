import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/app/view/widgets/app_view.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/themes/app_theme.dart';
import 'package:quran_app/modules/prayer_time/prayer_time.dart';
import 'package:quran_app/modules/settings/domain/settings_usecase.dart';
import 'package:quran_app/modules/settings/presentation/blocs/cubit/settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(locator<ThemeLocalData>()),
        ),
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
      child: const AppView(),
    );
  }
}
