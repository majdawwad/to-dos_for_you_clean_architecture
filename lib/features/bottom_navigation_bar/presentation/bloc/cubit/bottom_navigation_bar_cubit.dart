import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarHomeState());

  void navigateToHome() {
    emit(BottomNavigationBarHomeState());
  }

  void navigateToUserTasks() {
    emit(BottomNavigationBarUserTasksState());
  }

  void navigateToSettings() {
    emit(BottomNavigationBarSettingsState());
  }
}
