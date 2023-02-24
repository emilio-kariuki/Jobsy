part of 'show_post_bloc.dart';

abstract class ShowPostEvent extends Equatable {
  const ShowPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostPressed extends ShowPostEvent {}

class RemovePostPressed extends ShowPostEvent {}