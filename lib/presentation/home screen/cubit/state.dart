abstract class HomeState {}

class HomeInitialState extends HomeState {}

class ErrorOccurred extends HomeState {
  final String error;

  ErrorOccurred({required this.error});
}

class HomeLoading extends HomeState {}

class DataAdded extends HomeState {}

class CreatePlanSuccess extends HomeState {}

class TripSuccess extends HomeState {}

class HomeSuccess extends HomeState {}

class NavigationBarChanged extends HomeState {}

class UserDataSuccess extends HomeState {}

class UpdateDataSuccess extends HomeState {}

class DeleteUserSuccess extends HomeState {}

class DataSuccess extends HomeState {}

class TripLoading extends HomeState {}

class AddToFavorite extends HomeState {}

class RemovedFromFavorite extends HomeState {}
