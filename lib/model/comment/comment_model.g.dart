// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: json['id'] as String?,
      content: json['content'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : UserModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdBy': instance.createdBy?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
