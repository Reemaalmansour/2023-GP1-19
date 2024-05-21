import 'package:freezed_annotation/freezed_annotation.dart';

import '../place/place_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@unfreezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    required String? gender,
    required String? age,
    required String? imageUrl,
    required List<String>? tripsIds,
    required List<String>? sharedTripsIds,
    required List<String>? favPlacesIds,
    required List<String>? listOfInterestsTypes,
    required List<PlaceModel>? favPlaces,
    required String? password,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
