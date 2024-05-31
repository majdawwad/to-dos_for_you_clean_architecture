import 'package:equatable/equatable.dart';

abstract class BottomNavigationBarState extends Equatable {
  const BottomNavigationBarState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationBarInitial extends BottomNavigationBarState {}

class BottomNavigationBarHomeState extends BottomNavigationBarState {}

class BottomNavigationBarUserTasksState extends BottomNavigationBarState {}

class BottomNavigationBarSettingsState extends BottomNavigationBarState {}
