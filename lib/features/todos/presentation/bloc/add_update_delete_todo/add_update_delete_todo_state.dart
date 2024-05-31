part of 'add_update_delete_todo_bloc.dart';

abstract class AddUpdateDeleteTodoState extends Equatable {
  const AddUpdateDeleteTodoState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeleteTodoInitial extends AddUpdateDeleteTodoState {}

class LoadingAddUpdateDeleteTodoState extends AddUpdateDeleteTodoState {}

class SuccessAddUpdateDeleteTodoState extends AddUpdateDeleteTodoState {
  final String successMessage;
  const SuccessAddUpdateDeleteTodoState({
    required this.successMessage,
  });
  @override
  List<Object> get props => [successMessage];
}

class ErrorAddUpdateDeleteTodoState extends AddUpdateDeleteTodoState {
  final String errorMessage;
  const ErrorAddUpdateDeleteTodoState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
