import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;

  AuthBloc({required this.signInUseCase})
      : super(const AuthInitial(obscureText: true)) {
    on<AuthEvent>((event, emit) async {
      final String cachedLanguageCode =
          await LanguageCacheHelper().getCachedLanguageCode();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
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
          case const (CredentionalsFailure):
            return cachedLanguageCode == "en"
                ? credentionalsFailureMessage
                : credentionalsFailureMessageAr;

          default:
            return cachedLanguageCode == "en"
                ? unexpectedWrongMessage
                : unexpectedWrongMessageAr;
        }
      }

      AuthState mapFailureOrSignInUserToState(
          FailureOrSignInAuth either, String message) {
        return either.fold(
          (failure) {
            sharedPreferences.setBool(isLogin, false);
            return AuthIsErrorState(
              message: mapFailureToMessageInfo(failure),
            );
          },
          (_) {
            sharedPreferences.setBool(isLogin, true);
            return AuthIsLoadedState(message: message);
          },
        );
      }

      if (event is AuthSignInEvent) {
        emit(AuthIsLoadingState());

        final signInOrFailureUser = await signInUseCase(event.userData);

        emit(
          mapFailureOrSignInUserToState(
            signInOrFailureUser,
            cachedLanguageCode == "en" ? signInSuccessEn : signInSuccessAr,
          ),
        );
      } else if (event is AuthToggleObscureTextEvent) {
        final currentObscureText = event.obscureText ? false : true;
        emit(AuthObsecureTextState(obscureText: currentObscureText));
      }
    });
  }
}
