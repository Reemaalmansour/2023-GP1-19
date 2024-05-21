// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) => Viewport(
      northeast: Location.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: Location.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast.toJson(),
      'southwest': instance.southwest.toJson(),
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      height: json['height'] as int,
      htmlAttributions: (json['html_attributions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      photoReference: json['photo_reference'] as String,
      width: json['width'] as int,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'height': instance.height,
      'html_attributions': instance.htmlAttributions,
      'photo_reference': instance.photoReference,
      'width': instance.width,
    };

GooglePlacesModel _$GooglePlacesModelFromJson(Map<String, dynamic> json) =>
    GooglePlacesModel(
      geometry: json['geometry'] as Map<String, dynamic>?,
      icon: json['icon'] as String?,
      iconBackgroundColor: json['icon_background_color'] as String?,
      iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
      name: json['name'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reference: json['reference'] as String?,
      scope: json['scope'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userRatingsTotal: json['user_ratings_total'] as int?,
      vicinity: json['vicinity'] as String?,
    );

Map<String, dynamic> _$GooglePlacesModelToJson(GooglePlacesModel instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'icon': instance.icon,
      'icon_background_color': instance.iconBackgroundColor,
      'icon_mask_base_uri': instance.iconMaskBaseUri,
      'name': instance.name,
      'photos': instance.photos?.map((e) => e.toJson()).toList(),
      'place_id': instance.placeId,
      'rating': instance.rating,
      'reference': instance.reference,
      'scope': instance.scope,
      'types': instance.types,
      'user_ratings_total': instance.userRatingsTotal,
      'vicinity': instance.vicinity,
    };
