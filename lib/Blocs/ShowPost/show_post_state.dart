part of 'show_post_bloc.dart';

abstract class ShowPostState extends Equatable {
  const ShowPostState();
  
  @override
  List<Object> get props => [];
}

class ShowPostInitial extends ShowPostState {}

class ShowPostLoaded extends ShowPostState {}
