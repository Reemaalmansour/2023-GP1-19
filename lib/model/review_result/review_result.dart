import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../review_model/review_model.dart';

part 'review_result.freezed.dart';
part 'review_result.g.dart';

@unfreezed
@immutable
@HiveType(typeId: 2)
abstract class ReviewResult with _$ReviewResult {
  const factory ReviewResult({
    @HiveField(0) required final String? name,
    @HiveField(1) required final double? rating,
    @HiveField(2) required final List<ReviewModel>? reviews,
  }) = _ReviewResult;

  factory ReviewResult.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultFromJson(json);
}
