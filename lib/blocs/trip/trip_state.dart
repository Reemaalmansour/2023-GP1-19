part of 'trip_bloc.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

final class TripLoaded extends TripState {
  final List<TripModelN> trips;

  TripLoaded({
    this.trips = const <TripModelN>[],
  });

  @override
  List<Object> get props => [trips];
}

final class TripLoading extends TripState {}

final class TripAddLoading extends TripState {}

final class TripAddSuccess extends TripState {
  final String message;

  const TripAddSuccess({
    this.message = '',
  });

  @override
  List<Object> get props => [message];
}

final class TripError extends TripState {
  final String message;

  const TripError({
    this.message = '',
  });

  @override
  List<Object> get props => [message];
}

final class TripEmpty extends TripState {}

final class TripSuccess extends TripState {
  final String message;

  const TripSuccess({
    this.message = '',
  });

  @override
  List<Object> get props => [message];
}

final class TripFailure extends TripState {
  final String message;

  const TripFailure({
    this.message = '',
  });

  @override
  List<Object> get props => [message];
}
