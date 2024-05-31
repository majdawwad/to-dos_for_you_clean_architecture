part of 'update_delete_user_todo_bloc.dart';

sealed class UpdateDeleteUserTodoState extends Equatable {
  const UpdateDeleteUserTodoState();

  @override
  List<Object> get props => [];
}

final class UpdateDeleteUserTodoInitial extends UpdateDeleteUserTodoState {}

class LoadingUpdateDeleteUserTodoState extends UpdateDeleteUserTodoState {}

class SuccessUpdateDeleteUserTodoState extends UpdateDeleteUserTodoState {
  final String successMessage;
  const SuccessUpdateDeleteUserTodoState({
    required this.successMessage,
  });
  @override
  List<Object> get props => [successMessage];
}

class ErrorUpdateDeleteUserTodoState extends UpdateDeleteUserTodoState {
  final String errorMessage;
  const ErrorUpdateDeleteUserTodoState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
