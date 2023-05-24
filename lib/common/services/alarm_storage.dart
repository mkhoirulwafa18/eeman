import 'package:hive/hive.dart';
import 'package:quran_app/modules/prayer_time/models/alarm_model.dart';

class AlarmStorage {
  AlarmStorage._(this._box);
  static const _alarmStorageBox = '_alarmStorageBox';
  static const _alarmList = '_alarmList';
  final Box<Alarm> _box;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<AlarmStorage> getInstance() async {
    final box = await Hive.openBox<Alarm>(_alarmStorageBox);
    return AlarmStorage._(box);
  }

  Alarm? _getValue<T>(Object key, {required Alarm defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  Future<void> _setValue<T>(Object key, Alarm value) => _box.put(key, value);

  Alarm getAlarmList() => _getValue<Alarm>(_alarmList, defaultValue: Alarm())!;

  Future<void> setAlarmList(Alarm alarmList) =>
      _setValue<Alarm>(_alarmList, alarmList);
}
