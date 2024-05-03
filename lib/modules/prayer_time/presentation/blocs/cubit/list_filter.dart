import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/common/services/preferences.dart';

class ListFilterPrayerTimeCubit extends Cubit<List<String>> {
  ListFilterPrayerTimeCubit() : super([]);

  List<String>? previousState = [];

  // TODO(mkhoirulwafa18): Ganti pakai new system
  Future<void> init() async {
    final preferences = await Preferences.getInstance();
    final initial = preferences.getPrayerTimeFilter();
    emit([...initial]);
  }

  Future<void> onAddFilters(String filters) async {
    final preferences = await Preferences.getInstance();
    state.add(filters);
    await preferences.setPrayerTimeFilter([...state]);
    emit([...state]);
    debugPrint(state.toString());
  }

  Future<void> onRemoveFilters(String filter) async {
    final preferences = await Preferences.getInstance();
    state.removeWhere((x) => x == filter);
    await preferences.setPrayerTimeFilter([...state]);
    emit([...state]);
    debugPrint(state.toString());
  }

  // Save the prev state
  @override
  void onChange(Change<List<String>> change) {
    super.onChange(change);
    previousState = change.currentState;
  }
}
