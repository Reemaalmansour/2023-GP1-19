part of 'places_bloc.dart';

sealed class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object> get props => [];
}

final class LoadPlaces extends PlacesEvent {
  final List<PlaceModel> places;

  LoadPlaces({
    this.places = const <PlaceModel>[],
  });

  @override
  List<Object> get props => [places];
}

class AddPlace extends PlacesEvent {
  final PlaceModel place;

  AddPlace({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

final class UpdatePlace extends PlacesEvent {
  final PlaceModel updatedPlace;

  UpdatePlace({
    required this.updatedPlace,
  });

  @override
  List<Object> get props => [updatedPlace];
}

final class DeletePlace extends PlacesEvent {
  final PlaceModel place;

  DeletePlace({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

final class ToggleFav extends PlacesEvent {
  final PlaceModel place;

  ToggleFav({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

final class OnSearchAndAddToList extends PlacesEvent {
  final Prediction? place;
  final BuildContext? context;
  final bool isFav;

  const OnSearchAndAddToList({
    this.place,
    this.context,
    required this.isFav,
  });
}

final class removeAllFavPlaces extends PlacesEvent {
  const removeAllFavPlaces();
}
