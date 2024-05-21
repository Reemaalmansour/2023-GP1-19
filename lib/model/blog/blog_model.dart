import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:novoy/model/user/user_model.dart';

import '../place/place_model.dart';

part 'blog_model.freezed.dart';
part 'blog_model.g.dart';

@freezed
@immutable
abstract class BlogModel with _$BlogModel {
  const factory BlogModel({
    required String? id,
    required String? title,
    required String? experience,
    required List<String>? image,
    required DateTime? createdDate,
    required DateTime? updatedDate,
    required UserModel author,
    required int? like,
    required List<PlaceModel>? places,
  }) = _BlogModel;

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);
}
