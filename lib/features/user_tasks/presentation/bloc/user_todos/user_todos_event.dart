part of 'user_todos_bloc.dart';

abstract class UserTodosEvent extends Equatable {
  const UserTodosEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserTodosEvent extends UserTodosEvent {}
