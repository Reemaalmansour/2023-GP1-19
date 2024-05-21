import 'package:freezed_annotation/freezed_annotation.dart';

import '../todo_list/todo_list_model.dart';
import '../trip_member/trip_member_model.dart';
import '/model/trip_destination/trip_destination_model.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@unfreezed
@immutable
abstract class TripModel with _$TripModel {
  factory TripModel({
    required String? tripId,
    required TripMemberModel? createdBy,
    required String? name,
    required List<String>? destinationsIds,
    required DateTime? createOn,
    required List<TripMemberModel>? groupMembers,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<TripDestinationModel>? destinations,
    List<TodoListModel>? todoList,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}
