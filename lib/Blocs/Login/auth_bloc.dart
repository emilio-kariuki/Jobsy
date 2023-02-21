import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Blocs/Authentication/authentication_bloc.dart';
import 'package:jobsy_flutter/Repositories/Repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final HomeRepo homeRepo;
  final AuthenticationBloc authenticationBloc;
  AuthBloc({required this.homeRepo, required this.authenticationBloc})
      : super(LoginInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthStarted) {
        emit(LoginInitial());
        emit(RegisterInitial());
      }
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          final bool isLoggedIn = await homeRepo.login(
              email: event.email, password: event.password);
          if (isLoggedIn) {
            authenticationBloc.add(LoggedIn());
            emit(LoginSuccess());
          } else {
            emit(LoginFailure(message: 'Login Failed'));
          }
        } catch (e) {
          emit(LoginFailure(message: e.toString()));
        }
      }
      if (event is RegisterButtonPressed) {
        emit(RegisterLoading());
        try {
          final bool isRegistered = await homeRepo.register(
            email: event.email,
            password: event.password,
            name: event.name,
          );
          if (isRegistered) {
            authenticationBloc.add(LoggedIn());
            emit(RegisterSuccess());
          } else {
            emit(const RegisterFailure(message: 'Registration Failed'));
          }
        } catch (e) {
          emit(RegisterFailure(message: e.toString()));
        }
      }
    });
  }
}
