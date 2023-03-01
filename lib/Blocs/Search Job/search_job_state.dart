part of 'search_job_bloc.dart';

abstract class SearchJobState extends Equatable {
  const SearchJobState();

  @override
  List<Object> get props => [];
}

class SearchJobInitial extends SearchJobState {}

class SearchBarTapped extends SearchJobState {}

class SearchJobLoading extends SearchJobState {}

class SearchJobSuccess extends SearchJobState {
  List<JobModel> jobs;
  SearchJobSuccess({required this.jobs});
}

class SearchJobError extends SearchJobState {
  String message;
  SearchJobError({required this.message});
}
