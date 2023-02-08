import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial(0));

  void increment() {
    emit(CounterInitial(state.count + 1));
  }

  void decrement() {
    if (state.count != 0) {
      emit(CounterInitial(state.count - 1));
    }
  }

  void reset() {
    emit(const CounterInitial(0));
  }
}
