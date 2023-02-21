import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';
import 'package:meta/meta.dart';

import '../../Repositories/Repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final HomeRepo homeRepo;
  final SharedPreferencesManager sharedPreferencesManager;
  AuthenticationBloc(
      {required this.homeRepo, required this.sharedPreferencesManager})
      : super(AuthenticationUnitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        final bool isLoggedIn = await SharedPreferencesManager().isLoggedIn();

        if (isLoggedIn) {
          emit(AuthenticationAuthenticated());
          
        } else {
          emit(AuthenticationUnauthenticated());
        }

        if (event is LoggedIn) {
          emit(AuthenticationLoading());
          await Future.delayed(const Duration(seconds: 1));
          emit(AuthenticationAuthenticated());
        }

        if (event is LoggedOut) {
          emit(AuthenticationLoading());
          await sharedPreferencesManager.setLoggedIn(value: false);
          emit(AuthenticationUnauthenticated());
        }
      }
    });
  }
}
