import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';

import '../../Model/UserModel.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      if (event is GetUser) {
        emit(GetUserLoading());
        try {
          final user = await FirebaseAuthentication()
              .getUser(userId: event.userId)
              .then((value) {
            emit(GetUserLoaded(user: value));
          });
        } catch (e) {
          emit(GetUserError(message: e.toString()));
          // ignore: avoid_print
          print(e.toString());
        }
      }
    });
  }
}
