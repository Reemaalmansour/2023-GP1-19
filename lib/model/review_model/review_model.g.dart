// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewModelAdapter extends TypeAdapter<ReviewModel> {
  @override
  final int typeId = 1;

  @override
  ReviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewModel(
      authorName: fields[0] as String?,
      authorUrl: fields[1] as String?,
      language: fields[2] as String?,
      originalLanguage: fields[3] as String?,
      profilePhotoUrl: fields[4] as String?,
      rating: fields[5] as int?,
      relativeTimeDescription: fields[6] as String?,
      text: fields[7] as String?,
      time: fields[8] as int?,
      translated: fields[9] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.authorName)
      ..writeByte(1)
      ..write(obj.authorUrl)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.originalLanguage)
      ..writeByte(4)
      ..write(obj.profilePhotoUrl)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.relativeTimeDescription)
      ..writeByte(7)
      ..write(obj.text)
      ..writeByte(8)
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.translated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      authorName: json['author_name'] as String?,
      authorUrl: json['author_url'] as String?,
      language: json['language'] as String?,
      originalLanguage: json['original_language'] as String?,
      profilePhotoUrl: json['profile_photo_url'] as String?,
      rating: json['rating'] as int?,
      relativeTimeDescription: json['relative_time_description'] as String?,
      text: json['text'] as String?,
      time: json['time'] as int?,
      translated: json['translated'] as bool?,
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'author_name': instance.authorName,
      'author_url': instance.authorUrl,
      'language': instance.language,
      'original_language': instance.originalLanguage,
      'profile_photo_url': instance.profilePhotoUrl,
      'rating': instance.rating,
      'relative_time_description': instance.relativeTimeDescription,
      'text': instance.text,
      'time': instance.time,
      'translated': instance.translated,
    };
