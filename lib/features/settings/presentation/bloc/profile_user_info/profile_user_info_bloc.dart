import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/loaclization/language_cache_helper.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/profile_user.dart';
import '../../../domain/usecases/get_all_profile_user_info.dart';

part 'profile_user_info_event.dart';
part 'profile_user_info_state.dart';

class ProfileUserInfoBloc
    extends Bloc<ProfileUserInfoEvent, ProfileUserInfoState> {
  final GetAllProfileUserInfoUseCase getAllProfileUserInfoUseCase;
  ProfileUserInfoBloc({required this.getAllProfileUserInfoUseCase})
      : super(ProfileUserInfoInitialState()) {
    on<ProfileUserInfoEvent>((event, emit) async {
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
          case const (RefreshLoginFailure):
            return cachedLanguageCode == "en"
                ? refreshLoginFailureMessage
                : refreshLoginFailureMessageAr;
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

      if (event is GetAllProfileUserInfoEvent) {
        emit(LoadingProfileUserState());

        final FailureOrProfileUserInfo failureOrProfileUserInfo =
            await getAllProfileUserInfoUseCase();

        return failureOrProfileUserInfo.fold(
          (failure) => emit(
            ErrorProfileUserInfoState(
                message: mapFailureToMessageInfo(failure)),
          ),
          (profileUser) =>
              emit(LoadedProfileUserInfoState(profileUser: profileUser)),
        );
      }
    });
  }
}
