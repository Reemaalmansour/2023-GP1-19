// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripMemberModelImpl _$$TripMemberModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TripMemberModelImpl(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      uId: json['uId'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as String?,
    );

Map<String, dynamic> _$$TripMemberModelImplToJson(
        _$TripMemberModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'uId': instance.uId,
      'gender': instance.gender,
      'age': instance.age,
    };
