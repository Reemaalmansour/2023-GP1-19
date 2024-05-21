import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@unfreezed
@immutable
@HiveType(typeId: 1)
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    @JsonKey(name: "author_name")
    @HiveField(0)
    required final String? authorName,
    @JsonKey(name: "author_url") @HiveField(1) required final String? authorUrl,
    @HiveField(2) required final String? language,
    @JsonKey(name: "original_language")
    @HiveField(3)
    required final String? originalLanguage,
    @JsonKey(name: "profile_photo_url")
    @HiveField(4)
    required final String? profilePhotoUrl,
    @HiveField(5) required final int? rating,
    @JsonKey(name: "relative_time_description")
    @HiveField(6)
    required final String? relativeTimeDescription,
    @HiveField(7) required final String? text,
    @HiveField(8) required final int? time,
    @HiveField(9) required final bool? translated,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
