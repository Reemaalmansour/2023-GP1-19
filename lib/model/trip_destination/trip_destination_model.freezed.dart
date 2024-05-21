// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_destination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripDestinationModel _$TripDestinationModelFromJson(Map<String, dynamic> json) {
  return _TripDestinationModel.fromJson(json);
}

/// @nodoc
mixin _$TripDestinationModel {
  String? get destinationId => throw _privateConstructorUsedError;
  String? get tripId => throw _privateConstructorUsedError;
  TripMemberModel? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  set startDate(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get leaveDate => throw _privateConstructorUsedError;
  set leaveDate(DateTime? value) => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  set description(String? value) => throw _privateConstructorUsedError;
  List<String>? get image => throw _privateConstructorUsedError;
  set image(List<String>? value) => throw _privateConstructorUsedError;
  List<TripPlaceModel>? get visitedPlaces => throw _privateConstructorUsedError;
  set visitedPlaces(List<TripPlaceModel>? value) =>
      throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get location => throw _privateConstructorUsedError;
  @GeoPointConverter()
  set location(GeoPoint? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripDestinationModelCopyWith<TripDestinationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripDestinationModelCopyWith<$Res> {
  factory $TripDestinationModelCopyWith(TripDestinationModel value,
          $Res Function(TripDestinationModel) then) =
      _$TripDestinationModelCopyWithImpl<$Res, TripDestinationModel>;
  @useResult
  $Res call(
      {String? destinationId,
      String? tripId,
      TripMemberModel? createdBy,
      DateTime? createdAt,
      String? name,
      DateTime? startDate,
      DateTime? leaveDate,
      String? description,
      List<String>? image,
      List<TripPlaceModel>? visitedPlaces,
      @GeoPointConverter() GeoPoint? location});

  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class _$TripDestinationModelCopyWithImpl<$Res,
        $Val extends TripDestinationModel>
    implements $TripDestinationModelCopyWith<$Res> {
  _$TripDestinationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destinationId = freezed,
    Object? tripId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? name = freezed,
    Object? startDate = freezed,
    Object? leaveDate = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? visitedPlaces = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      destinationId: freezed == destinationId
          ? _value.destinationId
          : destinationId // ignore: cast_nullable_to_non_nullable
              as String?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leaveDate: freezed == leaveDate
          ? _value.leaveDate
          : leaveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      visitedPlaces: freezed == visitedPlaces
          ? _value.visitedPlaces
          : visitedPlaces // ignore: cast_nullable_to_non_nullable
              as List<TripPlaceModel>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
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
abstract class _$$TripDestinationModelImplCopyWith<$Res>
    implements $TripDestinationModelCopyWith<$Res> {
  factory _$$TripDestinationModelImplCopyWith(_$TripDestinationModelImpl value,
          $Res Function(_$TripDestinationModelImpl) then) =
      __$$TripDestinationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? destinationId,
      String? tripId,
      TripMemberModel? createdBy,
      DateTime? createdAt,
      String? name,
      DateTime? startDate,
      DateTime? leaveDate,
      String? description,
      List<String>? image,
      List<TripPlaceModel>? visitedPlaces,
      @GeoPointConverter() GeoPoint? location});

  @override
  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class __$$TripDestinationModelImplCopyWithImpl<$Res>
    extends _$TripDestinationModelCopyWithImpl<$Res, _$TripDestinationModelImpl>
    implements _$$TripDestinationModelImplCopyWith<$Res> {
  __$$TripDestinationModelImplCopyWithImpl(_$TripDestinationModelImpl _value,
      $Res Function(_$TripDestinationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destinationId = freezed,
    Object? tripId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? name = freezed,
    Object? startDate = freezed,
    Object? leaveDate = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? visitedPlaces = freezed,
    Object? location = freezed,
  }) {
    return _then(_$TripDestinationModelImpl(
      destinationId: freezed == destinationId
          ? _value.destinationId
          : destinationId // ignore: cast_nullable_to_non_nullable
              as String?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leaveDate: freezed == leaveDate
          ? _value.leaveDate
          : leaveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      visitedPlaces: freezed == visitedPlaces
          ? _value.visitedPlaces
          : visitedPlaces // ignore: cast_nullable_to_non_nullable
              as List<TripPlaceModel>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripDestinationModelImpl implements _TripDestinationModel {
  _$TripDestinationModelImpl(
      {required this.destinationId,
      required this.tripId,
      required this.createdBy,
      required this.createdAt,
      required this.name,
      required this.startDate,
      required this.leaveDate,
      required this.description,
      required this.image,
      required this.visitedPlaces,
      @GeoPointConverter() required this.location});

  factory _$TripDestinationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripDestinationModelImplFromJson(json);

  @override
  final String? destinationId;
  @override
  final String? tripId;
  @override
  final TripMemberModel? createdBy;
  @override
  final DateTime? createdAt;
  @override
  String? name;
  @override
  DateTime? startDate;
  @override
  DateTime? leaveDate;
  @override
  String? description;
  @override
  List<String>? image;
  @override
  List<TripPlaceModel>? visitedPlaces;
  @override
  @GeoPointConverter()
  GeoPoint? location;

  @override
  String toString() {
    return 'TripDestinationModel(destinationId: $destinationId, tripId: $tripId, createdBy: $createdBy, createdAt: $createdAt, name: $name, startDate: $startDate, leaveDate: $leaveDate, description: $description, image: $image, visitedPlaces: $visitedPlaces, location: $location)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripDestinationModelImplCopyWith<_$TripDestinationModelImpl>
      get copyWith =>
          __$$TripDestinationModelImplCopyWithImpl<_$TripDestinationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripDestinationModelImplToJson(
      this,
    );
  }
}

abstract class _TripDestinationModel implements TripDestinationModel {
  factory _TripDestinationModel(
          {required final String? destinationId,
          required final String? tripId,
          required final TripMemberModel? createdBy,
          required final DateTime? createdAt,
          required String? name,
          required DateTime? startDate,
          required DateTime? leaveDate,
          required String? description,
          required List<String>? image,
          required List<TripPlaceModel>? visitedPlaces,
          @GeoPointConverter() required GeoPoint? location}) =
      _$TripDestinationModelImpl;

  factory _TripDestinationModel.fromJson(Map<String, dynamic> json) =
      _$TripDestinationModelImpl.fromJson;

  @override
  String? get destinationId;
  @override
  String? get tripId;
  @override
  TripMemberModel? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  String? get name;
  set name(String? value);
  @override
  DateTime? get startDate;
  set startDate(DateTime? value);
  @override
  DateTime? get leaveDate;
  set leaveDate(DateTime? value);
  @override
  String? get description;
  set description(String? value);
  @override
  List<String>? get image;
  set image(List<String>? value);
  @override
  List<TripPlaceModel>? get visitedPlaces;
  set visitedPlaces(List<TripPlaceModel>? value);
  @override
  @GeoPointConverter()
  GeoPoint? get location;
  @GeoPointConverter()
  set location(GeoPoint? value);
  @override
  @JsonKey(ignore: true)
  _$$TripDestinationModelImplCopyWith<_$TripDestinationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
