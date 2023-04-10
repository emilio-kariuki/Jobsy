import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';

import '../../Firebase/Job.dart';

part 'apply_job_event.dart';
part 'apply_job_state.dart';

class ApplyJobBloc extends Bloc<ApplyJobEvent, ApplyJobState> {
  ApplyJobBloc() : super(ApplyJobInitial()) {
    on<ApplyButtonPressed>((event, emit) async {
      emit(ApplyJobLoading());
      try {
        await FirebaseJob().applyJobs(
          userId: FirebaseAuth.instance.currentUser!.uid,
          job: Job(
            name: event.name,
            description: event.description,
            amount: event.amount,
            location: event.location,
            image: event.image,
            createdAt: event.createdAt,
            userImage: event.userImage,
            userName: event.userName,
            userRole: event.userRole,
            belongsTo: event.belongsTo,
          ),
        );
        emit(ApplyJobSuccess());
      } catch (e) {
        emit(ApplyJobFailure(error: e.toString()));
      }
    });
  }
}
