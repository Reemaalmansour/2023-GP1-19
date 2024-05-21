import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_member_model.freezed.dart';
part 'trip_member_model.g.dart';

@unfreezed
@immutable
abstract class TripMemberModel with _$TripMemberModel {
  factory TripMemberModel({
    required final String? name,
    required final String? email,
    required final String? phone,
    required final String? uId,
    required final String? gender,
    required final String? age,
  }) = _TripMemberModel;

  factory TripMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TripMemberModelFromJson(json);
}
