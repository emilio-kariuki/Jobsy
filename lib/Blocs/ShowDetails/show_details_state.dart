part of 'show_details_bloc.dart';

abstract class ShowDetailsState extends Equatable {
  const ShowDetailsState();
  
  @override
  List<Object> get props => [];
}

class ShowDetailsInitial extends ShowDetailsState {}

class ShowDetailsLoading extends ShowDetailsState {}

class ShowDetailsLoaded extends ShowDetailsState {
  final JobModel job;
  ShowDetailsLoaded({required this.job});
}
