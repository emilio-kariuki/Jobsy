part of 'show_details_bloc.dart';

abstract class ShowDetailsEvent extends Equatable {
  const ShowDetailsEvent();

  @override
  List<Object> get props => [];
}

class ShowDetailsPressed extends ShowDetailsEvent {
  String id;
  ShowDetailsPressed({required this.id});
}

class RemoveDetailsPressed extends ShowDetailsEvent {}
