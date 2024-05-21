// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripModel _$TripModelFromJson(Map<String, dynamic> json) {
  return _TripModel.fromJson(json);
}

/// @nodoc
mixin _$TripModel {
  String? get tripId => throw _privateConstructorUsedError;
  set tripId(String? value) => throw _privateConstructorUsedError;
  TripMemberModel? get createdBy => throw _privateConstructorUsedError;
  set createdBy(TripMemberModel? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  List<String>? get destinationsIds => throw _privateConstructorUsedError;
  set destinationsIds(List<String>? value) =>
      throw _privateConstructorUsedError;
  DateTime? get createOn => throw _privateConstructorUsedError;
  set createOn(DateTime? value) => throw _privateConstructorUsedError;
  List<TripMemberModel>? get groupMembers => throw _privateConstructorUsedError;
  set groupMembers(List<TripMemberModel>? value) =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TripDestinationModel>? get destinations =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set destinations(List<TripDestinationModel>? value) =>
      throw _privateConstructorUsedError;
  List<TodoListModel>? get todoList => throw _privateConstructorUsedError;
  set todoList(List<TodoListModel>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripModelCopyWith<TripModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripModelCopyWith<$Res> {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) then) =
      _$TripModelCopyWithImpl<$Res, TripModel>;
  @useResult
  $Res call(
      {String? tripId,
      TripMemberModel? createdBy,
      String? name,
      List<String>? destinationsIds,
      DateTime? createOn,
      List<TripMemberModel>? groupMembers,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TripDestinationModel>? destinations,
      List<TodoListModel>? todoList});

  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class _$TripModelCopyWithImpl<$Res, $Val extends TripModel>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = freezed,
    Object? createdBy = freezed,
    Object? name = freezed,
    Object? destinationsIds = freezed,
    Object? createOn = freezed,
    Object? groupMembers = freezed,
    Object? destinations = freezed,
    Object? todoList = freezed,
  }) {
    return _then(_value.copyWith(
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationsIds: freezed == destinationsIds
          ? _value.destinationsIds
          : destinationsIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createOn: freezed == createOn
          ? _value.createOn
          : createOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupMembers: freezed == groupMembers
          ? _value.groupMembers
          : groupMembers // ignore: cast_nullable_to_non_nullable
              as List<TripMemberModel>?,
      destinations: freezed == destinations
          ? _value.destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<TripDestinationModel>?,
      todoList: freezed == todoList
          ? _value.todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<TodoListModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TripMemberModelCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $TripMemberModelCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripModelImplCopyWith<$Res>
    implements $TripModelCopyWith<$Res> {
  factory _$$TripModelImplCopyWith(
          _$TripModelImpl value, $Res Function(_$TripModelImpl) then) =
      __$$TripModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? tripId,
      TripMemberModel? createdBy,
      String? name,
      List<String>? destinationsIds,
      DateTime? createOn,
      List<TripMemberModel>? groupMembers,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TripDestinationModel>? destinations,
      List<TodoListModel>? todoList});

  @override
  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class __$$TripModelImplCopyWithImpl<$Res>
    extends _$TripModelCopyWithImpl<$Res, _$TripModelImpl>
    implements _$$TripModelImplCopyWith<$Res> {
  __$$TripModelImplCopyWithImpl(
      _$TripModelImpl _value, $Res Function(_$TripModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = freezed,
    Object? createdBy = freezed,
    Object? name = freezed,
    Object? destinationsIds = freezed,
    Object? createOn = freezed,
    Object? groupMembers = freezed,
    Object? destinations = freezed,
    Object? todoList = freezed,
  }) {
    return _then(_$TripModelImpl(
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationsIds: freezed == destinationsIds
          ? _value.destinationsIds
          : destinationsIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createOn: freezed == createOn
          ? _value.createOn
          : createOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupMembers: freezed == groupMembers
          ? _value.groupMembers
          : groupMembers // ignore: cast_nullable_to_non_nullable
              as List<TripMemberModel>?,
      destinations: freezed == destinations
          ? _value.destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<TripDestinationModel>?,
      todoList: freezed == todoList
          ? _value.todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<TodoListModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripModelImpl implements _TripModel {
  _$TripModelImpl(
      {required this.tripId,
      required this.createdBy,
      required this.name,
      required this.destinationsIds,
      required this.createOn,
      required this.groupMembers,
      @JsonKey(includeFromJson: false, includeToJson: false) this.destinations,
      this.todoList});

  factory _$TripModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripModelImplFromJson(json);

  @override
  String? tripId;
  @override
  TripMemberModel? createdBy;
  @override
  String? name;
  @override
  List<String>? destinationsIds;
  @override
  DateTime? createOn;
  @override
  List<TripMemberModel>? groupMembers;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TripDestinationModel>? destinations;
  @override
  List<TodoListModel>? todoList;

  @override
  String toString() {
    return 'TripModel(tripId: $tripId, createdBy: $createdBy, name: $name, destinationsIds: $destinationsIds, createOn: $createOn, groupMembers: $groupMembers, destinations: $destinations, todoList: $todoList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      __$$TripModelImplCopyWithImpl<_$TripModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripModelImplToJson(
      this,
    );
  }
}

abstract class _TripModel implements TripModel {
  factory _TripModel(
      {required String? tripId,
      required TripMemberModel? createdBy,
      required String? name,
      required List<String>? destinationsIds,
      required DateTime? createOn,
      required List<TripMemberModel>? groupMembers,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<TripDestinationModel>? destinations,
      List<TodoListModel>? todoList}) = _$TripModelImpl;

  factory _TripModel.fromJson(Map<String, dynamic> json) =
      _$TripModelImpl.fromJson;

  @override
  String? get tripId;
  set tripId(String? value);
  @override
  TripMemberModel? get createdBy;
  set createdBy(TripMemberModel? value);
  @override
  String? get name;
  set name(String? value);
  @override
  List<String>? get destinationsIds;
  set destinationsIds(List<String>? value);
  @override
  DateTime? get createOn;
  set createOn(DateTime? value);
  @override
  List<TripMemberModel>? get groupMembers;
  set groupMembers(List<TripMemberModel>? value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<TripDestinationModel>? get destinations;
  @JsonKey(includeFromJson: false, includeToJson: false)
  set destinations(List<TripDestinationModel>? value);
  @override
  List<TodoListModel>? get todoList;
  set todoList(List<TodoListModel>? value);
  @override
  @JsonKey(ignore: true)
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
