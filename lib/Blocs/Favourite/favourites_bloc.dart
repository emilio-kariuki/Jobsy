// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) async {
      if (event is FavouriteAdded) {
        emit(FavouriteLoading());
        try {
          await FirebaseJob()
              .createFavourite(job: event.job, context: event.context)
              .then((value) {
            emit(FavouriteAddedSuccess());
          });
        } catch (e) {
          print(e.toString());
        }
      }

      if (event is FavouriteRemoved) {
        emit(FavouriteLoading());
        try {
          await FirebaseJob()
              .remove(id: event.id, collection: event.collection)
              .then((value) {
            emit(FavouriteRemovedSuccess());
          });
        } catch (e) {
          print(e.toString());
        }
      }
    });
  }
}
