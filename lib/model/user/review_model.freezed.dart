// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReviewModel {
  String? get authorName => throw _privateConstructorUsedError;
  String? get authorUrl => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get profilePhotoUrl => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  String? get relativeTimeDescription => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  int? get time => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReviewModelCopyWith<ReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewModelCopyWith<$Res> {
  factory $ReviewModelCopyWith(
          ReviewModel value, $Res Function(ReviewModel) then) =
      _$ReviewModelCopyWithImpl<$Res, ReviewModel>;
  @useResult
  $Res call(
      {String? authorName,
      String? authorUrl,
      String? language,
      String? profilePhotoUrl,
      int? rating,
      String? relativeTimeDescription,
      String? text,
      int? time});
}

/// @nodoc
class _$ReviewModelCopyWithImpl<$Res, $Val extends ReviewModel>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorName = freezed,
    Object? authorUrl = freezed,
    Object? language = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? relativeTimeDescription = freezed,
    Object? text = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      authorUrl: freezed == authorUrl
          ? _value.authorUrl
          : authorUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      relativeTimeDescription: freezed == relativeTimeDescription
          ? _value.relativeTimeDescription
          : relativeTimeDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewModelImplCopyWith<$Res>
    implements $ReviewModelCopyWith<$Res> {
  factory _$$ReviewModelImplCopyWith(
          _$ReviewModelImpl value, $Res Function(_$ReviewModelImpl) then) =
      __$$ReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? authorName,
      String? authorUrl,
      String? language,
      String? profilePhotoUrl,
      int? rating,
      String? relativeTimeDescription,
      String? text,
      int? time});
}

/// @nodoc
class __$$ReviewModelImplCopyWithImpl<$Res>
    extends _$ReviewModelCopyWithImpl<$Res, _$ReviewModelImpl>
    implements _$$ReviewModelImplCopyWith<$Res> {
  __$$ReviewModelImplCopyWithImpl(
      _$ReviewModelImpl _value, $Res Function(_$ReviewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorName = freezed,
    Object? authorUrl = freezed,
    Object? language = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? relativeTimeDescription = freezed,
    Object? text = freezed,
    Object? time = freezed,
  }) {
    return _then(_$ReviewModelImpl(
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      authorUrl: freezed == authorUrl
          ? _value.authorUrl
          : authorUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      relativeTimeDescription: freezed == relativeTimeDescription
          ? _value.relativeTimeDescription
          : relativeTimeDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl(
      {required this.authorName,
      required this.authorUrl,
      required this.language,
      required this.profilePhotoUrl,
      required this.rating,
      required this.relativeTimeDescription,
      required this.text,
      required this.time});

  @override
  final String? authorName;
  @override
  final String? authorUrl;
  @override
  final String? language;
  @override
  final String? profilePhotoUrl;
  @override
  final int? rating;
  @override
  final String? relativeTimeDescription;
  @override
  final String? text;
  @override
  final int? time;

  @override
  String toString() {
    return 'ReviewModel(authorName: $authorName, authorUrl: $authorUrl, language: $language, profilePhotoUrl: $profilePhotoUrl, rating: $rating, relativeTimeDescription: $relativeTimeDescription, text: $text, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewModelImpl &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorUrl, authorUrl) ||
                other.authorUrl == authorUrl) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(
                    other.relativeTimeDescription, relativeTimeDescription) ||
                other.relativeTimeDescription == relativeTimeDescription) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authorName, authorUrl, language,
      profilePhotoUrl, rating, relativeTimeDescription, text, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel(
      {required final String? authorName,
      required final String? authorUrl,
      required final String? language,
      required final String? profilePhotoUrl,
      required final int? rating,
      required final String? relativeTimeDescription,
      required final String? text,
      required final int? time}) = _$ReviewModelImpl;

  @override
  String? get authorName;
  @override
  String? get authorUrl;
  @override
  String? get language;
  @override
  String? get profilePhotoUrl;
  @override
  int? get rating;
  @override
  String? get relativeTimeDescription;
  @override
  String? get text;
  @override
  int? get time;
  @override
  @JsonKey(ignore: true)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
