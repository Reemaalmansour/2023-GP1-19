// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewResultAdapter extends TypeAdapter<ReviewResult> {
  @override
  final int typeId = 2;

  @override
  ReviewResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewResult(
      name: fields[0] as String?,
      rating: fields[1] as double?,
      reviews: (fields[2] as List?)?.cast<ReviewModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReviewResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewResultImpl _$$ReviewResultImplFromJson(Map<String, dynamic> json) =>
    _$ReviewResultImpl(
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReviewResultImplToJson(_$ReviewResultImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
    };
