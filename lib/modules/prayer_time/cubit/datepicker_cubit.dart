import 'package:bloc/bloc.dart';

class DatepickerCubit extends Cubit<DateTime> {
  DatepickerCubit() : super(DateTime.now());

  void onSelectDate(DateTime selected) {
    emit(selected);
  }
}
