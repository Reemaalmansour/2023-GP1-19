import 'package:json_annotation/json_annotation.dart';

part 'google_places.g.dart';

@JsonSerializable()
class Location {
  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'lng')
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Viewport {
  @JsonKey(name: 'northeast')
  final Location northeast;

  @JsonKey(name: 'southwest')
  final Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);

  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}

@JsonSerializable()
class Photo {
  final int height;

  @JsonKey(name: 'html_attributions')
  final List<String> htmlAttributions;

  @JsonKey(name: 'photo_reference')
  final String photoReference;

  final int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class GooglePlacesModel {
  @JsonKey(name: 'geometry')
  final Map<String, dynamic>? geometry;

  final String? icon;

  @JsonKey(name: 'icon_background_color')
  final String? iconBackgroundColor;

  @JsonKey(name: 'icon_mask_base_uri')
  final String? iconMaskBaseUri;

  final String? name;

  final List<Photo>? photos;

  @JsonKey(name: 'place_id')
  final String? placeId;

  final double? rating;

  final String? reference;

  final String? scope;

  final List<String>? types;

  @JsonKey(name: 'user_ratings_total')
  final int? userRatingsTotal;

  final String? vicinity;

  GooglePlacesModel({
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  factory GooglePlacesModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePlacesModelToJson(this);
}
