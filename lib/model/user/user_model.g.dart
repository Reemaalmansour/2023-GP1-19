// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      uId: json['uId'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as String?,
      imageUrl: json['imageUrl'] as String?,
      tripsIds: (json['tripsIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sharedTripsIds: (json['sharedTripsIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favPlacesIds: (json['favPlacesIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      listOfInterestsTypes: (json['listOfInterestsTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favPlaces: (json['favPlaces'] as List<dynamic>?)
          ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'uId': instance.uId,
      'gender': instance.gender,
      'age': instance.age,
      'imageUrl': instance.imageUrl,
      'tripsIds': instance.tripsIds,
      'sharedTripsIds': instance.sharedTripsIds,
      'favPlacesIds': instance.favPlacesIds,
      'listOfInterestsTypes': instance.listOfInterestsTypes,
      'favPlaces': instance.favPlaces?.map((e) => e.toJson()).toList(),
      'password': instance.password,
    };
