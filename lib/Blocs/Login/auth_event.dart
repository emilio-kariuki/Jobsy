part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}

class RegisterButtonPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password, name,];

  @override
  String toString() =>
      'RegisterButtonPressed { email: $email, password: $password, name: $name }';
}

class AuthStarted extends AuthEvent {}

class ResetPasswordButtonPressed extends AuthEvent {
  final String email;

  const ResetPasswordButtonPressed({
    required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() =>
      'ResetPasswordButtonPressed { email: $email }';
}
