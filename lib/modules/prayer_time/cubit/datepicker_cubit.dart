import 'package:bloc/bloc.dart';

class DatepickerCubit extends Cubit<DateTime> {
  DatepickerCubit() : super(DateTime.now());

  DateTime? previousState = DateTime.now();

  void onSelectDate(DateTime selected) {
    emit(selected);
  }

  @override
  void onChange(Change<DateTime> change) {
    super.onChange(change);
    previousState = change.currentState;
  }
}
