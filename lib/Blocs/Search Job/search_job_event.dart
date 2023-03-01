part of 'search_job_bloc.dart';

abstract class SearchJobEvent extends Equatable {
  const SearchJobEvent();

  @override
  List<Object> get props => [];
}

class SearchBarTap extends SearchJobEvent {}

class SearchJobSubmitted extends SearchJobEvent {
  final String name;
 const SearchJobSubmitted({required this.name});
}

class HomeBar extends SearchJobEvent {}
