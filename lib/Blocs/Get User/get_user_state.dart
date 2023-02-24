part of 'get_user_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();
  
  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final UserModel user;

  const GetUserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserError extends GetUserState {
  final String message;

 const  GetUserError({required this.message});

  @override
  List<Object> get props => [message];
}
