import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_post_event.dart';
part 'show_post_state.dart';

class ShowPostBloc extends Bloc<ShowPostEvent, ShowPostState> {
  ShowPostBloc() : super(ShowPostInitial()) {
    on<ShowPostEvent>((event, emit) async {
      if (event is AddPostPressed) {
        emit(ShowPostInitial());
        await Future.delayed(const Duration(milliseconds: 100)).then((value) {
          emit(ShowPostLoaded());
        });
      }

      if (event is RemovePostPressed) {
        emit(ShowPostInitial());
      }
    });
  }
}
