import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<int> {
  CounterBloc(super.initialState);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
