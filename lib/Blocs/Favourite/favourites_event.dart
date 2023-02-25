part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class FavouriteAdded extends FavouritesEvent {
  JobModel job;
  BuildContext context;
  FavouriteAdded({required this.job, required this.context});
}

class FavouriteRemoved extends FavouritesEvent {

  int index;
  FavouriteRemoved({ required this.index});
}
