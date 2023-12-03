part of 'places_bloc.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

final class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<PlaceModel> places; // Define the places property here

  PlacesLoaded({required this.places});

  //* i can compare the old state with the new state if they are the sameList of places then i will not emit the new state
  @override
  List<Object> get props => [places];
}

final class PlacesError extends PlacesState {
  final String message;

  const PlacesError({
    this.message = '',
  });

  @override
  List<Object> get props => [message];
}
