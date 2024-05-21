// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripPlaceModel _$TripPlaceModelFromJson(Map<String, dynamic> json) {
  return _TripPlaceModel.fromJson(json);
}

/// @nodoc
mixin _$TripPlaceModel {
  String? get pId => throw _privateConstructorUsedError;
  set pId(String? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  set address(String? value) => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  set description(String? value) => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  set imageUrls(List<String>? value) => throw _privateConstructorUsedError;
  String? get lat => throw _privateConstructorUsedError;
  set lat(String? value) => throw _privateConstructorUsedError;
  String? get lng => throw _privateConstructorUsedError;
  set lng(String? value) => throw _privateConstructorUsedError;
  bool? get isFav => throw _privateConstructorUsedError;
  set isFav(bool? value) => throw _privateConstructorUsedError;
  List<String> get types => throw _privateConstructorUsedError;
  set types(List<String> value) => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  set createdAt(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get visitDate => throw _privateConstructorUsedError;
  set visitDate(DateTime? value) => throw _privateConstructorUsedError;
  TripMemberModel? get createdBy => throw _privateConstructorUsedError;
  set createdBy(TripMemberModel? value) => throw _privateConstructorUsedError;
  num? get rating => throw _privateConstructorUsedError;
  set rating(num? value) => throw _privateConstructorUsedError;
  String? get priceLevel => throw _privateConstructorUsedError;
  set priceLevel(String? value) => throw _privateConstructorUsedError;
  List<CommentModel>? get comments => throw _privateConstructorUsedError;
  set comments(List<CommentModel>? value) => throw _privateConstructorUsedError;
  List<String>? get reviews => throw _privateConstructorUsedError;
  set reviews(List<String>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripPlaceModelCopyWith<TripPlaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripPlaceModelCopyWith<$Res> {
  factory $TripPlaceModelCopyWith(
          TripPlaceModel value, $Res Function(TripPlaceModel) then) =
      _$TripPlaceModelCopyWithImpl<$Res, TripPlaceModel>;
  @useResult
  $Res call(
      {String? pId,
      String? name,
      String? address,
      String? description,
      List<String>? imageUrls,
      String? lat,
      String? lng,
      bool? isFav,
      List<String> types,
      DateTime? createdAt,
      DateTime? visitDate,
      TripMemberModel? createdBy,
      num? rating,
      String? priceLevel,
      List<CommentModel>? comments,
      List<String>? reviews});

  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class _$TripPlaceModelCopyWithImpl<$Res, $Val extends TripPlaceModel>
    implements $TripPlaceModelCopyWith<$Res> {
  _$TripPlaceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pId = freezed,
    Object? name = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? imageUrls = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? isFav = freezed,
    Object? types = null,
    Object? createdAt = freezed,
    Object? visitDate = freezed,
    Object? createdBy = freezed,
    Object? rating = freezed,
    Object? priceLevel = freezed,
    Object? comments = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_value.copyWith(
      pId: freezed == pId
          ? _value.pId
          : pId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
      isFav: freezed == isFav
          ? _value.isFav
          : isFav // ignore: cast_nullable_to_non_nullable
              as bool?,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitDate: freezed == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      priceLevel: freezed == priceLevel
          ? _value.priceLevel
          : priceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$TripPlaceModelImplCopyWith<$Res>
    implements $TripPlaceModelCopyWith<$Res> {
  factory _$$TripPlaceModelImplCopyWith(_$TripPlaceModelImpl value,
          $Res Function(_$TripPlaceModelImpl) then) =
      __$$TripPlaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? pId,
      String? name,
      String? address,
      String? description,
      List<String>? imageUrls,
      String? lat,
      String? lng,
      bool? isFav,
      List<String> types,
      DateTime? createdAt,
      DateTime? visitDate,
      TripMemberModel? createdBy,
      num? rating,
      String? priceLevel,
      List<CommentModel>? comments,
      List<String>? reviews});

  @override
  $TripMemberModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class __$$TripPlaceModelImplCopyWithImpl<$Res>
    extends _$TripPlaceModelCopyWithImpl<$Res, _$TripPlaceModelImpl>
    implements _$$TripPlaceModelImplCopyWith<$Res> {
  __$$TripPlaceModelImplCopyWithImpl(
      _$TripPlaceModelImpl _value, $Res Function(_$TripPlaceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pId = freezed,
    Object? name = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? imageUrls = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? isFav = freezed,
    Object? types = null,
    Object? createdAt = freezed,
    Object? visitDate = freezed,
    Object? createdBy = freezed,
    Object? rating = freezed,
    Object? priceLevel = freezed,
    Object? comments = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_$TripPlaceModelImpl(
      pId: freezed == pId
          ? _value.pId
          : pId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
      isFav: freezed == isFav
          ? _value.isFav
          : isFav // ignore: cast_nullable_to_non_nullable
              as bool?,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitDate: freezed == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as TripMemberModel?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      priceLevel: freezed == priceLevel
          ? _value.priceLevel
          : priceLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripPlaceModelImpl implements _TripPlaceModel {
  _$TripPlaceModelImpl(
      {required this.pId,
      required this.name,
      required this.address,
      required this.description,
      required this.imageUrls,
      required this.lat,
      required this.lng,
      required this.isFav,
      required this.types,
      required this.createdAt,
      required this.visitDate,
      required this.createdBy,
      required this.rating,
      required this.priceLevel,
      required this.comments,
      required this.reviews});

  factory _$TripPlaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripPlaceModelImplFromJson(json);

  @override
  String? pId;
  @override
  String? name;
  @override
  String? address;
  @override
  String? description;
  @override
  List<String>? imageUrls;
  @override
  String? lat;
  @override
  String? lng;
  @override
  bool? isFav;
  @override
  List<String> types;
  @override
  DateTime? createdAt;
  @override
  DateTime? visitDate;
  @override
  TripMemberModel? createdBy;
  @override
  num? rating;
  @override
  String? priceLevel;
  @override
  List<CommentModel>? comments;
  @override
  List<String>? reviews;

  @override
  String toString() {
    return 'TripPlaceModel(pId: $pId, name: $name, address: $address, description: $description, imageUrls: $imageUrls, lat: $lat, lng: $lng, isFav: $isFav, types: $types, createdAt: $createdAt, visitDate: $visitDate, createdBy: $createdBy, rating: $rating, priceLevel: $priceLevel, comments: $comments, reviews: $reviews)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripPlaceModelImplCopyWith<_$TripPlaceModelImpl> get copyWith =>
      __$$TripPlaceModelImplCopyWithImpl<_$TripPlaceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripPlaceModelImplToJson(
      this,
    );
  }
}

abstract class _TripPlaceModel implements TripPlaceModel {
  factory _TripPlaceModel(
      {required String? pId,
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
      required List<String>? reviews}) = _$TripPlaceModelImpl;

  factory _TripPlaceModel.fromJson(Map<String, dynamic> json) =
      _$TripPlaceModelImpl.fromJson;

  @override
  String? get pId;
  set pId(String? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String? get address;
  set address(String? value);
  @override
  String? get description;
  set description(String? value);
  @override
  List<String>? get imageUrls;
  set imageUrls(List<String>? value);
  @override
  String? get lat;
  set lat(String? value);
  @override
  String? get lng;
  set lng(String? value);
  @override
  bool? get isFav;
  set isFav(bool? value);
  @override
  List<String> get types;
  set types(List<String> value);
  @override
  DateTime? get createdAt;
  set createdAt(DateTime? value);
  @override
  DateTime? get visitDate;
  set visitDate(DateTime? value);
  @override
  TripMemberModel? get createdBy;
  set createdBy(TripMemberModel? value);
  @override
  num? get rating;
  set rating(num? value);
  @override
  String? get priceLevel;
  set priceLevel(String? value);
  @override
  List<CommentModel>? get comments;
  set comments(List<CommentModel>? value);
  @override
  List<String>? get reviews;
  set reviews(List<String>? value);
  @override
  @JsonKey(ignore: true)
  _$$TripPlaceModelImplCopyWith<_$TripPlaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
