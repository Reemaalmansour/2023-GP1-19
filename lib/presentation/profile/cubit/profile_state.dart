part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileErrorOccurred extends ProfileState {
  final String error;

  ProfileErrorOccurred({required this.error});
}

class DataAdded extends ProfileState {}


class HomeSuccess extends ProfileState {}

class NavigationBarChanged extends ProfileState {}
class UserDataSuccess extends ProfileState {}
class UpdateDataSuccess extends ProfileState {}
class DeleteUserSuccess extends ProfileState {}

class DataLoading extends ProfileState {}
class DataSuccess extends ProfileState {}

