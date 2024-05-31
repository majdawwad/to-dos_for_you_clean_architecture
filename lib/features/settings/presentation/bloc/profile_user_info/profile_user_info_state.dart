part of 'profile_user_info_bloc.dart';

class ProfileUserInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProfileUserInfoInitialState extends ProfileUserInfoState {}

class LoadingProfileUserState extends ProfileUserInfoState {}

class LoadedProfileUserInfoState extends ProfileUserInfoState {
  final ProfileUser profileUser;

  LoadedProfileUserInfoState({
    required this.profileUser,
  });

  @override
  List<Object?> get props => [profileUser];
}

class ErrorProfileUserInfoState extends ProfileUserInfoState {
  final String message;

  ErrorProfileUserInfoState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
