abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class AddFavouriteLoading extends FavouriteState {}

class AddFavouriteSuccess extends FavouriteState {}

class AddFavouriteError extends FavouriteState {
  final String error;
  AddFavouriteError({required this.error});
}

class RemoveFavouriteLoading extends FavouriteState {}

class RemoveFavouriteSuccess extends FavouriteState {}

class RemoveFavouriteError extends FavouriteState {
  final String error;
  RemoveFavouriteError({required this.error});
}

class GetFavouriteLoading extends FavouriteState {}

class GetFavouriteSuccess extends FavouriteState {}

class GetFavouriteError extends FavouriteState {
  final String error;
  GetFavouriteError({required this.error}); 
}

