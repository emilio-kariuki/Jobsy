import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';

part 'show_details_event.dart';
part 'show_details_state.dart';

class ShowDetailsBloc extends Bloc<ShowDetailsEvent, ShowDetailsState> {
  ShowDetailsBloc() : super(ShowDetailsInitial()) {
    on<ShowDetailsEvent>((event, emit) async {
      if (event is ShowDetailsPressed) {
        emit(ShowDetailsInitial());
        await Future.delayed(const Duration(milliseconds: 100))
            .then((value) async {
          emit(ShowDetailsLoading());
          try {
            Job job = await FirebaseJob().getJobDetails(id: event.id);
            emit(ShowDetailsLoaded(job: job));
          } catch (e) {
            print(e.toString());
          }
        });
      }

      if (event is RemoveDetailsPressed) {
        emit(ShowDetailsInitial());
      }
    });
  }
}
