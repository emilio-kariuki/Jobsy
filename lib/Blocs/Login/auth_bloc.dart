import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Blocs/Authentication/authentication_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Repositories/Auth.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthentication firebaseAuthentication;
  final AuthenticationBloc authenticationBloc;
  AuthBloc({required this.firebaseAuthentication, required this.authenticationBloc})
      : super(LoginInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthStarted) {
        emit(LoginInitial());
        emit(RegisterInitial());
      }
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          final bool isLoggedIn = await Auth().login(
            email: event.email,
            password: event.password,
          );
          if (isLoggedIn) {
            authenticationBloc.add(LoggedIn());
           await SharedPreferencesManager().setLoggedIn(value: isLoggedIn);
            emit(LoginSuccess());
          } else {
            emit(const LoginFailure(message: 'Login Failed'));
          }
        } catch (e) {
          emit(LoginFailure(message: e.toString()));
        }
      }
      if (event is RegisterButtonPressed) {
        emit(RegisterLoading());
        try {
          final bool isRegistered = await Auth().register(
            email: event.email,
            password: event.password,
            name: event.name,
          );
          if (isRegistered) {
            authenticationBloc.add(LoggedIn());
             await SharedPreferencesManager().setLoggedIn(value: isRegistered);
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
