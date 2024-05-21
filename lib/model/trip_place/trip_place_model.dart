import 'package:freezed_annotation/freezed_annotation.dart';

import '../comment/comment_model.dart';
import '../trip_member/trip_member_model.dart';

part 'trip_place_model.freezed.dart';
part 'trip_place_model.g.dart';

@unfreezed
@immutable
abstract class TripPlaceModel with _$TripPlaceModel {
  factory TripPlaceModel({
    required String? pId,
    required String? name,
    required String? address,
    required String? description,
    required List<String>? imageUrls,
    required String? lat,
    required String? lng,
    required bool? isFav,
    required List<String> types,
    required DateTime? createdAt,
    required DateTime? visitDate,
    required TripMemberModel? createdBy,
    required num? rating,
    required String? priceLevel,
    required List<CommentModel>? comments,
    required List<String>? reviews,
  }) = _TripPlaceModel;

  factory TripPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$TripPlaceModelFromJson(json);
}
