// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoListModelImpl _$$TodoListModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoListModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      isCompleted: json['isCompleted'] as bool?,
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TodoListModelImplToJson(_$TodoListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author?.toJson(),
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'assignees': instance.assignees?.map((e) => e.toJson()).toList(),
    };
