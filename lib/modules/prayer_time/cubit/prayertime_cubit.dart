import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prayertime_state.dart';

class PrayertimeCubit extends Cubit<PrayertimeState> {
  PrayertimeCubit() : super(PrayertimeInitial());
}
