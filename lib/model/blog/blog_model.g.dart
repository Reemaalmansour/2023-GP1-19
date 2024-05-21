// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlogModelImpl _$$BlogModelImplFromJson(Map<String, dynamic> json) =>
    _$BlogModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      experience: json['experience'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      like: json['like'] as int?,
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BlogModelImplToJson(_$BlogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'experience': instance.experience,
      'image': instance.image,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'author': instance.author.toJson(),
      'like': instance.like,
      'places': instance.places?.map((e) => e.toJson()).toList(),
    };
