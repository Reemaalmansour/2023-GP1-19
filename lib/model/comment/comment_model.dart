import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:novoy/model/user/user_model.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
@immutable
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    final String? id,
    final String? content,
    final UserModel? createdBy,
    final DateTime? createdAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
