import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/services/notifications.dart';
import 'package:quran_app/locator.dart';
import 'package:quran_app/modules/prayer_time/models/alarm_model.dart';
import 'package:quran_app/services/app_path_provider.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> init() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await AppPathProvider.initPath();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await NotificationHelper().initializeNotification();
  setStatusBar(color: backgroundColor2, brightness: Brightness.light);

  /// Specifies the `SystemUiMode` to have visible when the application is running.
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );

  setupLocator();
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await init();

    runApp(await builder());
  }, (error, stack) {
    log(error.toString(), error: error, stackTrace: stack);
  });
}
