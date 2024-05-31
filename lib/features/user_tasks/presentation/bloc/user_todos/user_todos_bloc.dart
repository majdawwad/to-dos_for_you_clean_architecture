import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_todo.dart';
import '../../../domain/usecases/get_all_user_todos.dart';

part 'user_todos_event.dart';
part 'user_todos_state.dart';

class UserTodosBloc extends Bloc<UserTodosEvent, UserTodosState> {
  final GetAllUserTodosUseCase getAllUserTodosUseCase;
  UserTodosBloc({
    required this.getAllUserTodosUseCase,
  }) : super(UserTodosInitial()) {
    on<UserTodosEvent>(
      (event, emit) async {
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
            case const (EmptyCacheFailure):
              return cachedLanguageCode == "en"
                  ? emptyCachedFailureMessage
                  : emptyCachedFailureMessageAr;

            default:
              return cachedLanguageCode == "en"
                  ? unexpectedWrongMessage
                  : unexpectedWrongMessageAr;
          }
        }

        UserTodosState mapFailureOrUserTodosToState(FailureOrUserTodos either) {
          return either.fold(
            (failure) {
              return ErrorUserTodoState(
                message: mapFailureToMessageInfo(failure),
              );
            },
            (userTodos) {
              return LoadedUserTodoState(userTodos: userTodos);
            },
          );
        }

        if (event is GetAllUserTodosEvent) {
          emit(LoadingUserTodoState());

          final userTodosOrFailureUserTodos = await getAllUserTodosUseCase();

          emit(
            mapFailureOrUserTodosToState(userTodosOrFailureUserTodos),
          );
        }
      },
    );
  }
}
