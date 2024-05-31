part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignInEvent extends AuthEvent {
  final User userData;
  const AuthSignInEvent({required this.userData});

  @override
  List<Object> get props => [userData];
}

class AuthToggleObscureTextEvent extends AuthEvent {
  final bool obscureText;

  const AuthToggleObscureTextEvent({
    required this.obscureText,
  });

  @override
  List<Object> get props => [obscureText];
}
