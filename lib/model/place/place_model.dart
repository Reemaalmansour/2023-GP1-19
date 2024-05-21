import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../review_result/review_result.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

// "name":"Rest Night Hotel Suites- - AL Nafal",
//       "rating":3.3,
//       "reviews"

@unfreezed
@immutable
@HiveType(typeId: 3)
abstract class PlaceModel with _$PlaceModel {
  factory PlaceModel({
    @HiveField(0) required final String? pId,
    @HiveField(1) required final String? name,
    @HiveField(2) required final String? address,
    @HiveField(3) required final String? description,
    @HiveField(4) required final String? image,
    @HiveField(5) required final List<String>? imageUrls,
    @HiveField(6) required final String? lat,
    @HiveField(7) required final String? lng,
    @HiveField(8) required final List<String>? types,
    @HiveField(9) required bool? isFav,
    @HiveField(10) final double? rating,
    @HiveField(11) final String? reference,
    @HiveField(12) final String? vicinity,
    @HiveField(13)
    @JsonKey(name: "user_ratings_total")
    final double? userTotalRating,
    @HiveField(14) bool? openNow,
    @HiveField(15) @JsonKey(name: "price_level") final int? priceLevel,
    @HiveField(16) final ReviewResult? reviewsResult,
    @HiveField(17) final DateTime? VisitDate,
    // types
    @HiveField(18) final List<String>? Type,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }
}
