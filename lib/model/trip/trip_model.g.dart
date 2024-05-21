// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripModelImpl _$$TripModelImplFromJson(Map<String, dynamic> json) =>
    _$TripModelImpl(
      tripId: json['tripId'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : TripMemberModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      name: json['name'] as String?,
      destinationsIds: (json['destinationsIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createOn: json['createOn'] == null
          ? null
          : DateTime.parse(json['createOn'] as String),
      groupMembers: (json['groupMembers'] as List<dynamic>?)
          ?.map((e) => TripMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      todoList: (json['todoList'] as List<dynamic>?)
          ?.map((e) => TodoListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TripModelImplToJson(_$TripModelImpl instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'createdBy': instance.createdBy?.toJson(),
      'name': instance.name,
      'destinationsIds': instance.destinationsIds,
      'createOn': instance.createOn?.toIso8601String(),
      'groupMembers': instance.groupMembers?.map((e) => e.toJson()).toList(),
      'todoList': instance.todoList?.map((e) => e.toJson()).toList(),
    };
