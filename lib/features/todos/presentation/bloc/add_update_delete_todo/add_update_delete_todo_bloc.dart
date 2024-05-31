import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/add_todo.dart';
import '../../../domain/usecases/delete_todo.dart';
import '../../../domain/usecases/update_todo.dart';

part 'add_update_delete_todo_event.dart';
part 'add_update_delete_todo_state.dart';

class AddUpdateDeleteTodoBloc
    extends Bloc<AddUpdateDeleteTodoEvent, AddUpdateDeleteTodoState> {
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  AddUpdateDeleteTodoBloc({
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(AddUpdateDeleteTodoInitial()) {
    on<AddUpdateDeleteTodoEvent>((event, emit) async {
      final String cachedLanguageCode =
          await LanguageCacheHelper().getCachedLanguageCode();

      String mapFailureToMessageInfo(Failure failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            return cachedLanguageCode == "en"
                ? serverFailureMessage
                : serverFailureMessageAr;
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

      AddUpdateDeleteTodoState mapFailureOrAddUpdateDeleteTodoToState(
          FailureOrTodoos either, String message) {
        return either.fold(
          (failure) {
            return ErrorAddUpdateDeleteTodoState(
                errorMessage: mapFailureToMessageInfo(failure));
          },
          (_) {
            return SuccessAddUpdateDeleteTodoState(successMessage: message);
          },
        );
      }

      if (event is AddTodoEvent) {
        emit(LoadingAddUpdateDeleteTodoState());

        final addOrFailureTodo = await addTodoUseCase(event.todo);

        emit(
          mapFailureOrAddUpdateDeleteTodoToState(
            addOrFailureTodo,
            cachedLanguageCode == "en" ? addTodoSuccessEn : addTodoSuccessAr,
          ),
        );
      } else if (event is UpdateTodoEvent) {
        emit(LoadingAddUpdateDeleteTodoState());

        final updateOrFailureTodo = await updateTodoUseCase(event.todo);

        emit(
          mapFailureOrAddUpdateDeleteTodoToState(
            updateOrFailureTodo,
            cachedLanguageCode == "en"
                ? updateTodoSuccessEn
                : updateTodoSuccessAr,
          ),
        );
      } else if (event is DeleteTodoEvent) {
        emit(LoadingAddUpdateDeleteTodoState());

        final deleteOrFailureTodo = await deleteTodoUseCase(event.todoId);

        emit(
          mapFailureOrAddUpdateDeleteTodoToState(
            deleteOrFailureTodo,
            cachedLanguageCode == "en"
                ? deleteTodoSuccessEn
                : deleteTodoSuccessAr,
          ),
        );
      }
    });
  }
}
