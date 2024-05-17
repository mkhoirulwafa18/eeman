import 'package:bloc/bloc.dart';
import 'package:quran_app/common/common.dart';

/// Cubit to manage the list of hidden prayer times
class ListFilterPrayerTimeCubit extends Cubit<List<String>> {
  /// Constructor initializes the cubit with the [filterStorage] instance
  ListFilterPrayerTimeCubit(this.filterStorage) : super([]);

  /// Local storage instance for prayer time filters
  final PrayerTimeFilterListLocalData filterStorage;

  /// Previous state of the cubit
  List<String>? previousState = [];

  /// Initializes the cubit by retrieving the hidden prayer times from local storage
  Future<void> init() async {
    final hiddenPray = await filterStorage.getListValue();

    if (hiddenPray != null) {
      emit(hiddenPray);
    } else {
      emit([]);
    }
  }

  /// Adds a hidden prayer time to the list and updates local storage
  Future<void> onAddHiddenPray(String prayName) async {
    final updatedList = <String>[...state, prayName];
    await filterStorage.setListValue(updatedList);
    emit(updatedList);
  }

  /// Removes a hidden prayer time from the list and updates local storage
  Future<void> onRemoveHiddenPray(String prayName) async {
    final updatedList = <String>[...state]..remove(prayName);
    await filterStorage.setListValue(updatedList);
    emit(updatedList);
  }

  /// Saves the previous state of the cubit
  @override
  void onChange(Change<List<String>> change) {
    super.onChange(change);
    previousState = change.currentState;
  }
}
