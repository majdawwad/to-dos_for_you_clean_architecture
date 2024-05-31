part of 'update_delete_user_todo_bloc.dart';

sealed class UpdateDeleteUserTodoEvent extends Equatable {
  const UpdateDeleteUserTodoEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserTodoEvent extends UpdateDeleteUserTodoEvent {
  final UserTodo userTodo;
  const UpdateUserTodoEvent({
    required this.userTodo,
  });

  @override
  List<Object> get props => [userTodo];
}

class DeleteUserTodoEvent extends UpdateDeleteUserTodoEvent {
  final int userTodoId;
  const DeleteUserTodoEvent({
    required this.userTodoId,
  });

  @override
  List<Object> get props => [userTodoId];
}
