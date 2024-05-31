part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodosEvent {}

class RefreshAllTodosEvent extends TodosEvent {}

class GetTodoEvent extends TodosEvent {
  final int todoId;
  const GetTodoEvent({
    required this.todoId,
  });

  @override
  List<Object> get props => [todoId];
}
