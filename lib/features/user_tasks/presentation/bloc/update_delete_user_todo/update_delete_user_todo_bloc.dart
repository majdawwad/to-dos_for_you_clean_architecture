import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/user_todo.dart';
import '../../../domain/usecases/delete_user_todo.dart';
import '../../../domain/usecases/update_user_todo.dart';

part 'update_delete_user_todo_event.dart';
part 'update_delete_user_todo_state.dart';

class UpdateDeleteUserTodoBloc
    extends Bloc<UpdateDeleteUserTodoEvent, UpdateDeleteUserTodoState> {
  final UpdateUserTodoUseCase updateUserTodoUseCase;
  final DeleteUserTodoUseCase deleteUserTodoUseCase;

  UpdateDeleteUserTodoBloc({
    required this.updateUserTodoUseCase,
    required this.deleteUserTodoUseCase,
  }) : super(UpdateDeleteUserTodoInitial()) {
    on<UpdateDeleteUserTodoEvent>((event, emit) async {
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

      UpdateDeleteUserTodoState mapFailureOrAddUpdateDeleteTodoToState(
          FailureOrUserTodo either, String message) {
        return either.fold(
          (failure) {
            return ErrorUpdateDeleteUserTodoState(
                errorMessage: mapFailureToMessageInfo(failure));
          },
          (_) {
            return SuccessUpdateDeleteUserTodoState(successMessage: message);
          },
        );
      }

      if (event is UpdateUserTodoEvent) {
        emit(LoadingUpdateDeleteUserTodoState());

        final updateOrFailureUserTodo =
            await updateUserTodoUseCase(event.userTodo);

        emit(
          mapFailureOrAddUpdateDeleteTodoToState(
            updateOrFailureUserTodo,
            cachedLanguageCode == "en"
                ? updateTodoSuccessEn
                : updateTodoSuccessAr,
          ),
        );
      } else if (event is DeleteUserTodoEvent) {
        emit(LoadingUpdateDeleteUserTodoState());

        final deleteOrFailureUserTodo =
            await deleteUserTodoUseCase(event.userTodoId);

        emit(
          mapFailureOrAddUpdateDeleteTodoToState(
            deleteOrFailureUserTodo,
            cachedLanguageCode == "en"
                ? deleteTodoSuccessEn
                : deleteTodoSuccessAr,
          ),
        );
      }
    });
  }
}
