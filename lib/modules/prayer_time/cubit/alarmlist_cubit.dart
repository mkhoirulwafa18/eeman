import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/common/services/alarm_storage.dart';
import 'package:quran_app/modules/prayer_time/models/alarm_model.dart';

class AlarmListCubit extends Cubit<List<DateTime>> {
  AlarmListCubit() : super([]);

  List<DateTime>? previousState = [];

  Future<void> init() async {
    final alarmStorage = await AlarmStorage.getInstance();
    final initial = alarmStorage.getAlarmList();
    emit([...initial.alarmList ?? []]);
  }

  Future<void> onAddReminder(DateTime hour) async {
    final alarmStorage = await AlarmStorage.getInstance();
    state.add(hour);
    final updatedState = Alarm()..alarmList = [...state];
    await alarmStorage.setAlarmList(updatedState);
    emit([...state]);
    debugPrint(state.toString());
  }

  Future<void> onRemoveReminder(DateTime hour) async {
    final alarmStorage = await AlarmStorage.getInstance();
    state.removeWhere((x) => x == hour);
    final updatedState = Alarm()..alarmList = [...state];
    await alarmStorage.setAlarmList(updatedState);
    emit([...state]);
    debugPrint(state.toString());
  }

  Future<void> clearReminder() async {
    final alarmStorage = await AlarmStorage.getInstance();
    state.clear();
    final updatedState = Alarm()..alarmList = [...state];
    await alarmStorage.setAlarmList(updatedState);
    emit([...state]);
    debugPrint(state.toString());
  }

  // Save the prev state
  @override
  void onChange(Change<List<DateTime>> change) {
    super.onChange(change);
    previousState = change.currentState;
  }
}
