import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../domain/usecases/get_todo.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/get_all_todos.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetAllTodosUseCase getAllTodosUseCase;
  final GetTodoUseCase getTodoUseCase;
  TodosBloc({
    required this.getAllTodosUseCase,
    required this.getTodoUseCase,
  }) : super(const TodosState()) {
    on<TodosEvent>(
      (event, emit) async {
        final String cachedLanguageCode =
            await LanguageCacheHelper().getCachedLanguageCode();

        String mapFailureToMessageInfo(Failure failure) {
          switch (failure.runtimeType) {
            case const (ServerFailure):
              return cachedLanguageCode == "en"
                  ? serverFailureMessage
                  : serverFailureMessageAr;
            case const (EmptyCacheFailure):
              return cachedLanguageCode == "en"
                  ? emptyCachedFailureMessage
                  : emptyCachedFailureMessageAr;
            case const (OfflineFailure):
              return cachedLanguageCode == "en"
                  ? offlineFailureMessage
                  : offlineFailureMessageAr;

            default:
              return cachedLanguageCode == "en"
                  ? unexpectedWrongMessage
                  : unexpectedWrongMessageAr;
          }
        }

        Future getAllTodos(Emitter<TodosState> emit) async {
          if (state.status == TodoStatus.loading) {
            final FailureOrTodos failureOrTodos = await getAllTodosUseCase();

            return failureOrTodos.fold(
              (failure) => state.copyWith(
                errorMessage: mapFailureToMessageInfo(failure),
              ),
              (todos) {
                return todos.isEmpty
                    ? emit(
                        state.copyWith(
                          status: TodoStatus.success,
                          hasReachedMax: true,
                        ),
                      )
                    : emit(
                        state.copyWith(
                          status: TodoStatus.success,
                          todos: todos,
                          hasReachedMax: false,
                        ),
                      );
              },
            );
          } else {
            final FailureOrTodos failureOrTodos =
                await getAllTodosUseCase(state.todos.length);

            return failureOrTodos.fold(
              (failure) => state.copyWith(
                errorMessage: mapFailureToMessageInfo(failure),
              ),
              (todos) {
                return todos.isEmpty
                    ? emit(
                        state.copyWith(
                          hasReachedMax: true,
                        ),
                      )
                    : emit(
                        state.copyWith(
                          status: TodoStatus.success,
                          todos: List.of(state.todos)..addAll(todos),
                          hasReachedMax: false,
                        ),
                      );
              },
            );
          }
        }

        if (event is GetAllTodosEvent) {
          if (state.hasReachedMax) return;
          return await getAllTodos(emit);
        } else if (event is RefreshAllTodosEvent) {
          if (state.hasReachedMax) return;
          return await getAllTodos(emit);
        } else if (event is GetTodoEvent) {
          emit(LoadingTodoState());

          final FailureOrTodo failureOrTodo =
              await getTodoUseCase(todoId: event.todoId);

          return failureOrTodo.fold(
            (failure) => emit(
              ErrorTodoState(message: mapFailureToMessageInfo(failure)),
            ),
            (todo) => emit(LoadedTodoState(todo: todo)),
          );
        }
      },
      transformer: droppable(),
    );
  }
}
