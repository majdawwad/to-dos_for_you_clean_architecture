part of 'add_update_delete_todo_bloc.dart';

abstract class AddUpdateDeleteTodoEvent extends Equatable {
  const AddUpdateDeleteTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends AddUpdateDeleteTodoEvent {
  final Todo todo;
  const AddTodoEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends AddUpdateDeleteTodoEvent {
  final Todo todo;
  const UpdateTodoEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends AddUpdateDeleteTodoEvent {
  final int todoId;
  const DeleteTodoEvent({
    required this.todoId,
  });

  @override
  List<Object> get props => [todoId];
}
