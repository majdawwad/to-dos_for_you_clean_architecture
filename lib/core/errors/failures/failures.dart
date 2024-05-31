import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ExistDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CredentionalsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class RefreshLoginFailure extends Failure {
  @override
  List<Object?> get props => [];
}
