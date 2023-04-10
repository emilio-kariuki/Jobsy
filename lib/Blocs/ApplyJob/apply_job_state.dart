part of 'apply_job_bloc.dart';

abstract class ApplyJobState extends Equatable {
  const ApplyJobState();
  
  @override
  List<Object> get props => [];
}

class ApplyJobInitial extends ApplyJobState {}


class ApplyJobLoading extends ApplyJobState {}

class ApplyJobSuccess extends ApplyJobState {}

class ApplyJobFailure extends ApplyJobState {
  final String error;

  ApplyJobFailure({required this.error});

  @override
  List<Object> get props => [error];
}