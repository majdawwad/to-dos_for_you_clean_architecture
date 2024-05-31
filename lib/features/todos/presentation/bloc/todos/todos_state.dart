part of 'todos_bloc.dart';

enum TodoStatus { loading, success, error }

class TodosState extends Equatable {
  final TodoStatus status;
  final List<Todo> todos;
  final bool hasReachedMax;
  final String errorMessage;

  const TodosState(
      {this.status = TodoStatus.loading,
      this.hasReachedMax = false,
      this.todos = const [],
      this.errorMessage = ""});

  TodosState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, todos, hasReachedMax, errorMessage];
}

class LoadingTodoState extends TodosState {}

class LoadedTodoState extends TodosState {
  final Todo todo;

  const LoadedTodoState({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

class ErrorTodoState extends TodosState {
  final String message;

  const ErrorTodoState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
