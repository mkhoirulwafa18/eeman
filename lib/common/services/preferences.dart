import 'package:hive/hive.dart';

class Preferences {
  Preferences._(this._box);
  static const _preferencesBox = '_preferencesBox';
  static const _lastSurahRead = '_lastSurahRead';
  static const _lastAyahRead = '_lastAyahRead';
  static const _prayerTimeFilter = '_prayerTimeFilter';
  final Box<Object> _box;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<Object>(_preferencesBox);
    return Preferences._(box);
  }

  T _getValue<T>(Object key, {required T defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(Object key, T value) => _box.put(key, value!);

  int getLastSurahRead() => _getValue(_lastSurahRead, defaultValue: 0);

  Future<void> setLastSurahRead(int indexSurah) =>
      _setValue(_lastSurahRead, indexSurah);

  int getLastAyahRead() => _getValue(_lastAyahRead, defaultValue: 0);

  Future<void> setLastAyahRead(int indexAyah) =>
      _setValue(_lastAyahRead, indexAyah);

  List<String> getPrayerTimeFilter() =>
      _getValue(_prayerTimeFilter, defaultValue: []);

  Future<void> setPrayerTimeFilter(List<String> filters) =>
      _setValue(_prayerTimeFilter, filters);
}
