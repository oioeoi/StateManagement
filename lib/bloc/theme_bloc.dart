import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<int> {
  ThemeBloc(super.initialState);
  void changeTheme() => emit(state);
}
