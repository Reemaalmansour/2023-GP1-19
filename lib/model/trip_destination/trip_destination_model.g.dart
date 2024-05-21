// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripDestinationModelImpl _$$TripDestinationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TripDestinationModelImpl(
      destinationId: json['destinationId'] as String?,
      tripId: json['tripId'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : TripMemberModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      leaveDate: json['leaveDate'] == null
          ? null
          : DateTime.parse(json['leaveDate'] as String),
      description: json['description'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      visitedPlaces: (json['visitedPlaces'] as List<dynamic>?)
          ?.map((e) => TripPlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['location'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$TripDestinationModelImplToJson(
        _$TripDestinationModelImpl instance) =>
    <String, dynamic>{
      'destinationId': instance.destinationId,
      'tripId': instance.tripId,
      'createdBy': instance.createdBy?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'name': instance.name,
      'startDate': instance.startDate?.toIso8601String(),
      'leaveDate': instance.leaveDate?.toIso8601String(),
      'description': instance.description,
      'image': instance.image,
      'visitedPlaces': instance.visitedPlaces?.map((e) => e.toJson()).toList(),
      'location': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.location, const GeoPointConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
