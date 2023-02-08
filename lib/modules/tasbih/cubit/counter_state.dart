part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  const CounterState(this.count);
  final int count;
  @override
  List<Object> get props => [count];
}

class CounterInitial extends CounterState {
  const CounterInitial(super.count);
}
