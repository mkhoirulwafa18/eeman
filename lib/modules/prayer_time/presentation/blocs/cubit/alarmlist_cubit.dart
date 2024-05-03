import 'package:bloc/bloc.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/local_data/alarm_list_local_data.dart';

class AlarmListCubit extends Cubit<List<DateTime>> {
  AlarmListCubit() : super([]);

  List<DateTime>? previousState = [];

  Future<void> init() async {
    final alarmStorage = locator<AlarmListLocalData>();
    final initial = await alarmStorage.getValue();

    if (initial != null) {
      final result = initial as List<dynamic>;
      result.map((encoded) => DateTime.parse(encoded as String)).toList();
      emit(result as List<DateTime>);
    } else {
      emit([]);
    }
  }

  // Save the prev state
  @override
  void onChange(Change<List<DateTime>> change) {
    super.onChange(change);
    previousState = change.currentState;
  }

  // Update Reminder State and Local Data
  Future<void> updateReminder(List<DateTime> updatedList) async {
    final alarmStorage = locator<AlarmListLocalData>();
    final reminders = updatedList.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit([...updatedList]);
  }

  Future<void> onAddReminder(DateTime hour) async {}

  Future<void> onRemoveReminder(DateTime hour) async {
    final alarmStorage = locator<AlarmListLocalData>();
    final reminders = state.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit([...state]);
  }

  Future<void> clearReminder() async {
    final alarmStorage = locator<AlarmListLocalData>();
    state.clear();
    final reminders = state.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit([...state]);
  }
}
