import 'package:bloc/bloc.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:quran_app/common/local_data/alarm_list_local_data.dart';
import 'package:quran_app/common/services/services.dart';

/// Cubit to manage the list of alarms
class AlarmListCubit extends Cubit<List<DateTime>> {
  /// Constructor initializes the cubit with the [alarmStorage] instance
  AlarmListCubit(this.alarmStorage) : super([]);

  /// Local storage instance for alarms
  final AlarmListLocalData alarmStorage;

  /// Previous state of the cubit
  List<DateTime>? previousState = [];

  /// Initializes the cubit by retrieving the alarms from local storage
  Future<void> init() async {
    final initial = await alarmStorage.getValue();

    if (initial != null) {
      final result = initial as List<dynamic>;
      final alarms = result.map((encoded) => DateTime.parse(encoded as String)).toList();
      emit(alarms);
    } else {
      emit([]);
    }
  }

  /// Saves the previous state of the cubit
  @override
  void onChange(Change<List<DateTime>> change) {
    super.onChange(change);
    previousState = change.currentState;
  }

  /// Updates the reminder state and local data
  Future<void> updateReminder(List<DateTime> updatedList) async {
    final reminders = updatedList.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit([...updatedList]);
  }

  /// Adds a new reminder and updates local storage
  Future<void> onAddReminder(DateTime hour) async {
    final updatedList = <DateTime>[...state, hour];
    final reminders = updatedList.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit(updatedList);
  }

  /// Removes a reminder from the list and updates local storage
  Future<void> onRemoveReminder(DateTime hour) async {
    final updatedList = <DateTime>[...state]..remove(hour);
    final reminders = updatedList.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit(updatedList);
  }

  /// Clears all reminders and updates local storage
  Future<void> clearReminder() async {
    state.clear();
    final reminders = state.map((dateTime) => dateTime.toIso8601String()).toList();
    await alarmStorage.setListValue(reminders);
    emit([...state]);
  }

  Future<void> scheduleNotification({
    required bool isPassed,
    required DateTime selectedDate,
    required String title,
  }) async {
    final permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();

    if (permissionStatus == PermissionStatus.unknown || permissionStatus == PermissionStatus.denied) {
      await NotificationPermissions.requestNotificationPermissions();
    }

    if (isPassed) {
      if (state.contains(selectedDate)) {
        await onRemoveReminder(selectedDate);
      } else {
        await onAddReminder(selectedDate);
      }
    }
    await NotificationHelper().scheduledNotification(
      hour: selectedDate.hour,
      minutes: selectedDate.minute,
      id: selectedDate.microsecondsSinceEpoch,
      title: title,
      sound: 'adzan',
    );
  }
}
