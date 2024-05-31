part of 'user_todos_bloc.dart';

abstract class UserTodosState extends Equatable {
  const UserTodosState();

  @override
  List<Object> get props => [];
}

final class UserTodosInitial extends UserTodosState {}

class LoadingUserTodoState extends UserTodosState {}

class LoadedUserTodoState extends UserTodosState {
  final List<UserTodo> userTodos;

  const LoadedUserTodoState({
    required this.userTodos,
  });

  @override
  List<Object> get props => [userTodos];
}

class ErrorUserTodoState extends UserTodosState {
  final String message;

  const ErrorUserTodoState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
