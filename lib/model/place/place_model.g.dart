// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final int typeId = 3;

  @override
  PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      pId: fields[0] as String?,
      name: fields[1] as String?,
      address: fields[2] as String?,
      description: fields[3] as String?,
      image: fields[4] as String?,
      imageUrls: (fields[5] as List?)?.cast<String>(),
      lat: fields[6] as String?,
      lng: fields[7] as String?,
      types: (fields[8] as List?)?.cast<String>(),
      isFav: fields[9] as bool?,
      rating: fields[10] as double?,
      reference: fields[11] as String?,
      vicinity: fields[12] as String?,
      userTotalRating: fields[13] as double?,
      openNow: fields[14] as bool?,
      priceLevel: fields[15] as int?,
      reviewsResult: fields[16] as ReviewResult?,
      VisitDate: fields[17] as DateTime?,
      Type: (fields[18] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.pId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.imageUrls)
      ..writeByte(6)
      ..write(obj.lat)
      ..writeByte(7)
      ..write(obj.lng)
      ..writeByte(8)
      ..write(obj.types)
      ..writeByte(9)
      ..write(obj.isFav)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.reference)
      ..writeByte(12)
      ..write(obj.vicinity)
      ..writeByte(13)
      ..write(obj.userTotalRating)
      ..writeByte(14)
      ..write(obj.openNow)
      ..writeByte(15)
      ..write(obj.priceLevel)
      ..writeByte(16)
      ..write(obj.reviewsResult)
      ..writeByte(17)
      ..write(obj.VisitDate)
      ..writeByte(18)
      ..write(obj.Type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceModelImpl _$$PlaceModelImplFromJson(Map<String, dynamic> json) =>
    _$PlaceModelImpl(
      pId: json['pId'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isFav: json['isFav'] as bool?,
      rating: (json['rating'] as num?)?.toDouble(),
      reference: json['reference'] as String?,
      vicinity: json['vicinity'] as String?,
      userTotalRating: (json['user_ratings_total'] as num?)?.toDouble(),
      openNow: json['openNow'] as bool?,
      priceLevel: json['price_level'] as int?,
      reviewsResult: json['reviewsResult'] == null
          ? null
          : ReviewResult.fromJson(
              json['reviewsResult'] as Map<String, dynamic>),
      VisitDate: json['VisitDate'] == null
          ? null
          : DateTime.parse(json['VisitDate'] as String),
      Type: (json['Type'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PlaceModelImplToJson(_$PlaceModelImpl instance) =>
    <String, dynamic>{
      'pId': instance.pId,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'image': instance.image,
      'imageUrls': instance.imageUrls,
      'lat': instance.lat,
      'lng': instance.lng,
      'types': instance.types,
      'isFav': instance.isFav,
      'rating': instance.rating,
      'reference': instance.reference,
      'vicinity': instance.vicinity,
      'user_ratings_total': instance.userTotalRating,
      'openNow': instance.openNow,
      'price_level': instance.priceLevel,
      'reviewsResult': instance.reviewsResult?.toJson(),
      'VisitDate': instance.VisitDate?.toIso8601String(),
      'Type': instance.Type,
    };
