import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:novoy/model/user/user_model.dart';

part 'todo_list_model.freezed.dart';
part 'todo_list_model.g.dart';

@freezed
@immutable
abstract class TodoListModel with _$TodoListModel {
  const factory TodoListModel({
    final String? id,
    final String? title,
    final UserModel? author,
    final DateTime? createdDate,
    final DateTime? updatedDate,
    final bool? isCompleted,
    final List<UserModel>? assignees,
  }) = _TodoListModel;

  factory TodoListModel.fromJson(Map<String, dynamic> json) =>
      _$TodoListModelFromJson(json);
}
