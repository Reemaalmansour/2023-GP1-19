// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewResult _$ReviewResultFromJson(Map<String, dynamic> json) {
  return _ReviewResult.fromJson(json);
}

/// @nodoc
mixin _$ReviewResult {
  @HiveField(0)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(1)
  double? get rating => throw _privateConstructorUsedError;
  @HiveField(2)
  List<ReviewModel>? get reviews => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewResultCopyWith<ReviewResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewResultCopyWith<$Res> {
  factory $ReviewResultCopyWith(
          ReviewResult value, $Res Function(ReviewResult) then) =
      _$ReviewResultCopyWithImpl<$Res, ReviewResult>;
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) double? rating,
      @HiveField(2) List<ReviewModel>? reviews});
}

/// @nodoc
class _$ReviewResultCopyWithImpl<$Res, $Val extends ReviewResult>
    implements $ReviewResultCopyWith<$Res> {
  _$ReviewResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? rating = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewResultImplCopyWith<$Res>
    implements $ReviewResultCopyWith<$Res> {
  factory _$$ReviewResultImplCopyWith(
          _$ReviewResultImpl value, $Res Function(_$ReviewResultImpl) then) =
      __$$ReviewResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) double? rating,
      @HiveField(2) List<ReviewModel>? reviews});
}

/// @nodoc
class __$$ReviewResultImplCopyWithImpl<$Res>
    extends _$ReviewResultCopyWithImpl<$Res, _$ReviewResultImpl>
    implements _$$ReviewResultImplCopyWith<$Res> {
  __$$ReviewResultImplCopyWithImpl(
      _$ReviewResultImpl _value, $Res Function(_$ReviewResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? rating = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_$ReviewResultImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewResultImpl implements _ReviewResult {
  const _$ReviewResultImpl(
      {@HiveField(0) required this.name,
      @HiveField(1) required this.rating,
      @HiveField(2) required this.reviews});

  factory _$ReviewResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewResultImplFromJson(json);

  @override
  @HiveField(0)
  final String? name;
  @override
  @HiveField(1)
  final double? rating;
  @override
  @HiveField(2)
  final List<ReviewModel>? reviews;

  @override
  String toString() {
    return 'ReviewResult(name: $name, rating: $rating, reviews: $reviews)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewResultImplCopyWith<_$ReviewResultImpl> get copyWith =>
      __$$ReviewResultImplCopyWithImpl<_$ReviewResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewResultImplToJson(
      this,
    );
  }
}

abstract class _ReviewResult implements ReviewResult {
  const factory _ReviewResult(
          {@HiveField(0) required final String? name,
          @HiveField(1) required final double? rating,
          @HiveField(2) required final List<ReviewModel>? reviews}) =
      _$ReviewResultImpl;

  factory _ReviewResult.fromJson(Map<String, dynamic> json) =
      _$ReviewResultImpl.fromJson;

  @override
  @HiveField(0)
  String? get name;
  @override
  @HiveField(1)
  double? get rating;
  @override
  @HiveField(2)
  List<ReviewModel>? get reviews;
  @override
  @JsonKey(ignore: true)
  _$$ReviewResultImplCopyWith<_$ReviewResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
