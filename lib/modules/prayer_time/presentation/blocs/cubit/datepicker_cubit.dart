import 'package:bloc/bloc.dart';

/// Cubit to manage the selected date
class DatepickerCubit extends Cubit<DateTime> {
  /// Constructor initializes the cubit with the current date
  DatepickerCubit() : super(DateTime.now());

  /// Previous state of the cubit
  DateTime? previousState = DateTime.now();

  /// Selects a date and emits it as the new state
  void onSelectDate(DateTime selected) {
    emit(selected);
  }

  /// Resets the cubit to the initial state (current date)
  void resetToInitial() {
    emit(DateTime.now());
  }

  /// Saves the previous state of the cubit
  @override
  void onChange(Change<DateTime> change) {
    super.onChange(change);
    previousState = change.currentState;
  }
}
