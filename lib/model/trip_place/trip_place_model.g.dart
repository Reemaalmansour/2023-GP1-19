// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripPlaceModelImpl _$$TripPlaceModelImplFromJson(Map<String, dynamic> json) =>
    _$TripPlaceModelImpl(
      pId: json['pId'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      isFav: json['isFav'] as bool?,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
      createdBy: json['createdBy'] == null
          ? null
          : TripMemberModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      rating: json['rating'] as num?,
      priceLevel: json['priceLevel'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$TripPlaceModelImplToJson(
        _$TripPlaceModelImpl instance) =>
    <String, dynamic>{
      'pId': instance.pId,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'imageUrls': instance.imageUrls,
      'lat': instance.lat,
      'lng': instance.lng,
      'isFav': instance.isFav,
      'types': instance.types,
      'createdAt': instance.createdAt?.toIso8601String(),
      'visitDate': instance.visitDate?.toIso8601String(),
      'createdBy': instance.createdBy?.toJson(),
      'rating': instance.rating,
      'priceLevel': instance.priceLevel,
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews,
    };
