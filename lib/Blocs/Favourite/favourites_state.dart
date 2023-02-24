part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
  
  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouriteLoading extends FavouritesState {}

class FavouriteAddedSuccess extends FavouritesState {}

class FavouriteRemovedSuccess extends FavouritesState {}