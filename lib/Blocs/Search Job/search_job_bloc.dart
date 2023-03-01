import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobDetailsModel.dart';

part 'search_job_event.dart';
part 'search_job_state.dart';

class SearchJobBloc extends Bloc<SearchJobEvent, SearchJobState> {
  SearchJobBloc() : super(SearchJobInitial()) {
    on<SearchJobEvent>((event, emit) async {
      if (event is HomeBar) {
        emit(SearchJobInitial());
      }
      if (event is SearchBarTap) {
        emit(SearchBarTapped());
      }
      if (event is SearchJobSubmitted) {
        try {
          emit(SearchJobLoading());
          await FirebaseFirestore.instance
              .collection('job')
              .where('name', isGreaterThanOrEqualTo: event.name)
              .get()
              .then((value) {
            emit(SearchJobSuccess(
                jobs: value.docs
                    .map<JobModel>((e) => JobModel.fromJson(e.data()))
                    .toList()));
          });
        } catch (e) {
          emit(SearchJobError(message: e.toString()));
        }
      }
    });
  }
}
