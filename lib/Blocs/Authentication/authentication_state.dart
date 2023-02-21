part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState  extends Equatable{
  @override
  List<Object> get props => [];
}

class AuthenticationUnitialized extends AuthenticationState {
}

class AuthenticationAuthenticated extends AuthenticationState {
}

class AuthenticationUnauthenticated extends AuthenticationState {
}

class AuthenticationLoading extends AuthenticationState {
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}




