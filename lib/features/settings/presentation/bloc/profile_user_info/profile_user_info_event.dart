part of 'profile_user_info_bloc.dart';

abstract class ProfileUserInfoEvent extends Equatable {
  const ProfileUserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetAllProfileUserInfoEvent extends ProfileUserInfoEvent {}
