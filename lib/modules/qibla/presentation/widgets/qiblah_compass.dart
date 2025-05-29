import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/gen/assets.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/qibla/presentation/blocs/cubit/qibla_cubit.dart';
import 'package:quran_app/modules/qibla/presentation/blocs/state/qibla_state.dart';
import 'package:quran_app/modules/qibla/presentation/widgets/location_error.dart';

class QiblahCompass extends StatelessWidget {
  const QiblahCompass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QiblahCubit, QiblahState>(
      builder: (context, state) {
        // if (!state.isSupported) {
        //   return QiblahMaps();
        // }

        if (state.locationStatus.enabled == false) {
          return LocationErrorWidget(
            error: context.l10n.locationNotEnabledErrorMesage,
            callback: () => context.read<QiblahCubit>().requestPermissions(),
          );
        }

        switch (state.locationStatus.status) {
          case LocationPermission.always:
          case LocationPermission.whileInUse:
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                context.read<QiblahCubit>().dispose();
                SystemNavigator.pop();
              },
              child: const QiblahCompassWidget(),
            );
          case LocationPermission.denied:
            return LocationErrorWidget(
              error: context.l10n.locationDeniedErrorMesage,
              callback: () => context.read<QiblahCubit>().requestPermissions(),
            );
          case LocationPermission.deniedForever:
            return LocationErrorWidget(
              error: context.l10n.locationDeniedErrorMesage,
              callback: () => context.read<QiblahCubit>().requestPermissions(),
            );
          // case GeolocationStatus.unknown:
          //   return LocationErrorWidget(
          //     error: "Unknown Location service error",
          //     callback: () => _qiblahCubit.requestPermissions(),
          //   );
          // ignore: no_default_cases
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  const QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoading();
        }

        final qiblahDirection = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: qiblahDirection.direction * (pi / 180) * -1,
                child: Assets.icons.compass.svg(),
              ),
              Transform.rotate(
                angle: qiblahDirection.qiblah * (pi / 180) * -1,
                child: Assets.icons.needle.svg(
                  height: 300,
                ),
              ),
              Positioned(
                bottom: 8,
                child: Text('${qiblahDirection.offset.toStringAsFixed(3)}°'),
              ),
            ],
          ),
        );
      },
    );
  }
}
