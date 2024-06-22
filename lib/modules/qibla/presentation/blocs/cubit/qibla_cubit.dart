import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/modules/qibla/presentation/blocs/state/qibla_state.dart';

class QiblahCubit extends Cubit<QiblahState> {
  QiblahCubit()
      : super(const QiblahState(isSupported: false, locationStatus: LocationStatus(false, LocationPermission.denied)));

  Future<void> init() async {
    final isSupported = await FlutterQiblah.androidDeviceSensorSupport();
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    emit(
      QiblahState(
        isSupported: isSupported ?? true,
        locationStatus: locationStatus,
      ),
    );
  }

  Future<void> requestPermissions() async {
    await FlutterQiblah.requestPermissions();
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    emit(state.copyWith(locationStatus: locationStatus));
  }

  void dispose() {
    FlutterQiblah().dispose();
  }
}
