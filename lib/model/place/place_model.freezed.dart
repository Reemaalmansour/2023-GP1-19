// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return _PlaceModel.fromJson(json);
}

/// @nodoc
mixin _$PlaceModel {
  @HiveField(0)
  String? get pId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get address => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get lat => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get lng => throw _privateConstructorUsedError;
  @HiveField(8)
  List<String>? get types => throw _privateConstructorUsedError;
  @HiveField(9)
  bool? get isFav => throw _privateConstructorUsedError;
  @HiveField(9)
  set isFav(bool? value) => throw _privateConstructorUsedError;
  @HiveField(10)
  double? get rating => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get reference => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get vicinity => throw _privateConstructorUsedError;
  @HiveField(13)
  @JsonKey(name: "user_ratings_total")
  double? get userTotalRating => throw _privateConstructorUsedError;
  @HiveField(14)
  bool? get openNow => throw _privateConstructorUsedError;
  @HiveField(14)
  set openNow(bool? value) => throw _privateConstructorUsedError;
  @HiveField(15)
  @JsonKey(name: "price_level")
  int? get priceLevel => throw _privateConstructorUsedError;
  @HiveField(16)
  ReviewResult? get reviewsResult => throw _privateConstructorUsedError;
  @HiveField(17)
  DateTime? get VisitDate => throw _privateConstructorUsedError; // types
  @HiveField(18)
  List<String>? get Type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaceModelCopyWith<PlaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceModelCopyWith<$Res> {
  factory $PlaceModelCopyWith(
          PlaceModel value, $Res Function(PlaceModel) then) =
      _$PlaceModelCopyWithImpl<$Res, PlaceModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? pId,
      @HiveField(1) String? name,
      @HiveField(2) String? address,
      @HiveField(3) String? description,
      @HiveField(4) String? image,
      @HiveField(5) List<String>? imageUrls,
      @HiveField(6) String? lat,
      @HiveField(7) String? lng,
      @HiveField(8) List<String>? types,
      @HiveField(9) bool? isFav,
      @HiveField(10) double? rating,
      @HiveField(11) String? reference,
      @HiveField(12) String? vicinity,
      @HiveField(13)
      @JsonKey(name: "user_ratings_total")
      double? userTotalRating,
      @HiveField(14) bool? openNow,
      @HiveField(15) @JsonKey(name: "price_level") int? priceLevel,
      @HiveField(16) ReviewResult? reviewsResult,
      @HiveField(17) DateTime? VisitDate,
      @HiveField(18) List<String>? Type});

  $ReviewResultCopyWith<$Res>? get reviewsResult;
}

/// @nodoc
class _$PlaceModelCopyWithImpl<$Res, $Val extends PlaceModel>
    implements $PlaceModelCopyWith<$Res> {
  _$PlaceModelCopyWithImpl(this._value, this._then);

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
    Object? image = freezed,
    Object? imageUrls = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? types = freezed,
    Object? isFav = freezed,
    Object? rating = freezed,
    Object? reference = freezed,
    Object? vicinity = freezed,
    Object? userTotalRating = freezed,
    Object? openNow = freezed,
    Object? priceLevel = freezed,
    Object? reviewsResult = freezed,
    Object? VisitDate = freezed,
    Object? Type = freezed,
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
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
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
      types: freezed == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFav: freezed == isFav
          ? _value.isFav
          : isFav // ignore: cast_nullable_to_non_nullable
              as bool?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      vicinity: freezed == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String?,
      userTotalRating: freezed == userTotalRating
          ? _value.userTotalRating
          : userTotalRating // ignore: cast_nullable_to_non_nullable
              as double?,
      openNow: freezed == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceLevel: freezed == priceLevel
          ? _value.priceLevel
          : priceLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewsResult: freezed == reviewsResult
          ? _value.reviewsResult
          : reviewsResult // ignore: cast_nullable_to_non_nullable
              as ReviewResult?,
      VisitDate: freezed == VisitDate
          ? _value.VisitDate
          : VisitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      Type: freezed == Type
          ? _value.Type
          : Type // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReviewResultCopyWith<$Res>? get reviewsResult {
    if (_value.reviewsResult == null) {
      return null;
    }

    return $ReviewResultCopyWith<$Res>(_value.reviewsResult!, (value) {
      return _then(_value.copyWith(reviewsResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaceModelImplCopyWith<$Res>
    implements $PlaceModelCopyWith<$Res> {
  factory _$$PlaceModelImplCopyWith(
          _$PlaceModelImpl value, $Res Function(_$PlaceModelImpl) then) =
      __$$PlaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? pId,
      @HiveField(1) String? name,
      @HiveField(2) String? address,
      @HiveField(3) String? description,
      @HiveField(4) String? image,
      @HiveField(5) List<String>? imageUrls,
      @HiveField(6) String? lat,
      @HiveField(7) String? lng,
      @HiveField(8) List<String>? types,
      @HiveField(9) bool? isFav,
      @HiveField(10) double? rating,
      @HiveField(11) String? reference,
      @HiveField(12) String? vicinity,
      @HiveField(13)
      @JsonKey(name: "user_ratings_total")
      double? userTotalRating,
      @HiveField(14) bool? openNow,
      @HiveField(15) @JsonKey(name: "price_level") int? priceLevel,
      @HiveField(16) ReviewResult? reviewsResult,
      @HiveField(17) DateTime? VisitDate,
      @HiveField(18) List<String>? Type});

  @override
  $ReviewResultCopyWith<$Res>? get reviewsResult;
}

/// @nodoc
class __$$PlaceModelImplCopyWithImpl<$Res>
    extends _$PlaceModelCopyWithImpl<$Res, _$PlaceModelImpl>
    implements _$$PlaceModelImplCopyWith<$Res> {
  __$$PlaceModelImplCopyWithImpl(
      _$PlaceModelImpl _value, $Res Function(_$PlaceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pId = freezed,
    Object? name = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? imageUrls = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? types = freezed,
    Object? isFav = freezed,
    Object? rating = freezed,
    Object? reference = freezed,
    Object? vicinity = freezed,
    Object? userTotalRating = freezed,
    Object? openNow = freezed,
    Object? priceLevel = freezed,
    Object? reviewsResult = freezed,
    Object? VisitDate = freezed,
    Object? Type = freezed,
  }) {
    return _then(_$PlaceModelImpl(
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
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
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
      types: freezed == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFav: freezed == isFav
          ? _value.isFav
          : isFav // ignore: cast_nullable_to_non_nullable
              as bool?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      vicinity: freezed == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String?,
      userTotalRating: freezed == userTotalRating
          ? _value.userTotalRating
          : userTotalRating // ignore: cast_nullable_to_non_nullable
              as double?,
      openNow: freezed == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceLevel: freezed == priceLevel
          ? _value.priceLevel
          : priceLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewsResult: freezed == reviewsResult
          ? _value.reviewsResult
          : reviewsResult // ignore: cast_nullable_to_non_nullable
              as ReviewResult?,
      VisitDate: freezed == VisitDate
          ? _value.VisitDate
          : VisitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      Type: freezed == Type
          ? _value.Type
          : Type // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceModelImpl implements _PlaceModel {
  _$PlaceModelImpl(
      {@HiveField(0) required this.pId,
      @HiveField(1) required this.name,
      @HiveField(2) required this.address,
      @HiveField(3) required this.description,
      @HiveField(4) required this.image,
      @HiveField(5) required this.imageUrls,
      @HiveField(6) required this.lat,
      @HiveField(7) required this.lng,
      @HiveField(8) required this.types,
      @HiveField(9) required this.isFav,
      @HiveField(10) this.rating,
      @HiveField(11) this.reference,
      @HiveField(12) this.vicinity,
      @HiveField(13) @JsonKey(name: "user_ratings_total") this.userTotalRating,
      @HiveField(14) this.openNow,
      @HiveField(15) @JsonKey(name: "price_level") this.priceLevel,
      @HiveField(16) this.reviewsResult,
      @HiveField(17) this.VisitDate,
      @HiveField(18) this.Type});

  factory _$PlaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? pId;
  @override
  @HiveField(1)
  final String? name;
  @override
  @HiveField(2)
  final String? address;
  @override
  @HiveField(3)
  final String? description;
  @override
  @HiveField(4)
  final String? image;
  @override
  @HiveField(5)
  final List<String>? imageUrls;
  @override
  @HiveField(6)
  final String? lat;
  @override
  @HiveField(7)
  final String? lng;
  @override
  @HiveField(8)
  final List<String>? types;
  @override
  @HiveField(9)
  bool? isFav;
  @override
  @HiveField(10)
  final double? rating;
  @override
  @HiveField(11)
  final String? reference;
  @override
  @HiveField(12)
  final String? vicinity;
  @override
  @HiveField(13)
  @JsonKey(name: "user_ratings_total")
  final double? userTotalRating;
  @override
  @HiveField(14)
  bool? openNow;
  @override
  @HiveField(15)
  @JsonKey(name: "price_level")
  final int? priceLevel;
  @override
  @HiveField(16)
  final ReviewResult? reviewsResult;
  @override
  @HiveField(17)
  final DateTime? VisitDate;
// types
  @override
  @HiveField(18)
  final List<String>? Type;

  @override
  String toString() {
    return 'PlaceModel(pId: $pId, name: $name, address: $address, description: $description, image: $image, imageUrls: $imageUrls, lat: $lat, lng: $lng, types: $types, isFav: $isFav, rating: $rating, reference: $reference, vicinity: $vicinity, userTotalRating: $userTotalRating, openNow: $openNow, priceLevel: $priceLevel, reviewsResult: $reviewsResult, VisitDate: $VisitDate, Type: $Type)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceModelImplCopyWith<_$PlaceModelImpl> get copyWith =>
      __$$PlaceModelImplCopyWithImpl<_$PlaceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceModelImplToJson(
      this,
    );
  }
}

abstract class _PlaceModel implements PlaceModel {
  factory _PlaceModel(
      {@HiveField(0) required final String? pId,
      @HiveField(1) required final String? name,
      @HiveField(2) required final String? address,
      @HiveField(3) required final String? description,
      @HiveField(4) required final String? image,
      @HiveField(5) required final List<String>? imageUrls,
      @HiveField(6) required final String? lat,
      @HiveField(7) required final String? lng,
      @HiveField(8) required final List<String>? types,
      @HiveField(9) required bool? isFav,
      @HiveField(10) final double? rating,
      @HiveField(11) final String? reference,
      @HiveField(12) final String? vicinity,
      @HiveField(13)
      @JsonKey(name: "user_ratings_total")
      final double? userTotalRating,
      @HiveField(14) bool? openNow,
      @HiveField(15) @JsonKey(name: "price_level") final int? priceLevel,
      @HiveField(16) final ReviewResult? reviewsResult,
      @HiveField(17) final DateTime? VisitDate,
      @HiveField(18) final List<String>? Type}) = _$PlaceModelImpl;

  factory _PlaceModel.fromJson(Map<String, dynamic> json) =
      _$PlaceModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get pId;
  @override
  @HiveField(1)
  String? get name;
  @override
  @HiveField(2)
  String? get address;
  @override
  @HiveField(3)
  String? get description;
  @override
  @HiveField(4)
  String? get image;
  @override
  @HiveField(5)
  List<String>? get imageUrls;
  @override
  @HiveField(6)
  String? get lat;
  @override
  @HiveField(7)
  String? get lng;
  @override
  @HiveField(8)
  List<String>? get types;
  @override
  @HiveField(9)
  bool? get isFav;
  @HiveField(9)
  set isFav(bool? value);
  @override
  @HiveField(10)
  double? get rating;
  @override
  @HiveField(11)
  String? get reference;
  @override
  @HiveField(12)
  String? get vicinity;
  @override
  @HiveField(13)
  @JsonKey(name: "user_ratings_total")
  double? get userTotalRating;
  @override
  @HiveField(14)
  bool? get openNow;
  @HiveField(14)
  set openNow(bool? value);
  @override
  @HiveField(15)
  @JsonKey(name: "price_level")
  int? get priceLevel;
  @override
  @HiveField(16)
  ReviewResult? get reviewsResult;
  @override
  @HiveField(17)
  DateTime? get VisitDate;
  @override // types
  @HiveField(18)
  List<String>? get Type;
  @override
  @JsonKey(ignore: true)
  _$$PlaceModelImplCopyWith<_$PlaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
