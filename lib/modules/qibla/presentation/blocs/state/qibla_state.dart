import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahState {
  const QiblahState({
    required this.isSupported,
    required this.locationStatus,
  });
  final bool isSupported;
  final LocationStatus locationStatus;

  QiblahState copyWith({
    bool? isSupported,
    LocationStatus? locationStatus,
  }) =>
      QiblahState(
        isSupported: isSupported ?? this.isSupported,
        locationStatus: locationStatus ?? this.locationStatus,
      );
}
