
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthErrorOccurred extends AuthState {
    final String error;

  AuthErrorOccurred({required this.error});
}
class EmailError extends AuthState {
    final String error;

    EmailError({required this.error});
}
class PasswordError extends AuthState {
    final String error;

    PasswordError({required this.error});
}

class AuthRegisterSuccess extends AuthState {}
class AuthCreateSuccess extends AuthState {}
class UserLoginSuccess extends AuthState {}

class AuthLoading extends AuthState {}
class DataLoading extends AuthState {}
class DataSuccess extends AuthState {}
class TouristPlacesGeted extends AuthState {}
class TripDataGeted extends AuthState {}
class HotelDataSuccess extends AuthState {}
class LogOut extends AuthState {}
class UserDataSuccess extends AuthState {}
class PasswordStateChanged extends AuthState {}
class ChecKEmail extends AuthState {}


