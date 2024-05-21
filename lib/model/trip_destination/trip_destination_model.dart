import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../trip_member/trip_member_model.dart';
import '../trip_place/trip_place_model.dart';

part 'trip_destination_model.freezed.dart';
part 'trip_destination_model.g.dart';

@unfreezed
@immutable
abstract class TripDestinationModel with _$TripDestinationModel {
  factory TripDestinationModel({
    required final String? destinationId,
    required final String? tripId,
    required final TripMemberModel? createdBy,
    required final DateTime? createdAt,
    required String? name,
    required DateTime? startDate,
    required DateTime? leaveDate,
    required String? description,
    required List<String>? image,
    required List<TripPlaceModel>? visitedPlaces,
    @GeoPointConverter() required GeoPoint? location,
  }) = _TripDestinationModel;

  factory TripDestinationModel.fromJson(Map<String, dynamic> json) =>
      _$TripDestinationModelFromJson(json);
}

class GeoPointConverter implements JsonConverter<GeoPoint, GeoPoint> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(GeoPoint geoPoint) {
    return geoPoint;
  }

  @override
  GeoPoint toJson(GeoPoint geoPoint) => geoPoint;
}
