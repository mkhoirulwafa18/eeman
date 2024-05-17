// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/modules/qibla/presentation/blocs/cubit/qibla_cubit.dart';
import 'package:quran_app/modules/qibla/presentation/blocs/state/qibla_state.dart';
import 'package:quran_app/modules/qibla/presentation/widgets/qiblah_compass.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key, required this.location});
  final Location location;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblahCubit()..init(),
      child: BasePage.noPadding(
        appBar: const CustomAppBar(
          title: 'Qibla',
        ),
        child: BlocBuilder<QiblahCubit, QiblahState>(
          builder: (context, state) {
            if (state.isSupported) {
              return const QiblahCompass();
            } else {
              return const Text('Sensor tidak didukung');
            }
          },
        ),
      ),
    );
  }
}
