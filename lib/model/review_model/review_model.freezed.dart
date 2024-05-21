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

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return _ReviewModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewModel {
  @JsonKey(name: "author_name")
  @HiveField(0)
  String? get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: "author_url")
  @HiveField(1)
  String? get authorUrl => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: "original_language")
  @HiveField(3)
  String? get originalLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: "profile_photo_url")
  @HiveField(4)
  String? get profilePhotoUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  int? get rating => throw _privateConstructorUsedError;
  @JsonKey(name: "relative_time_description")
  @HiveField(6)
  String? get relativeTimeDescription => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get text => throw _privateConstructorUsedError;
  @HiveField(8)
  int? get time => throw _privateConstructorUsedError;
  @HiveField(9)
  bool? get translated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {@JsonKey(name: "author_name") @HiveField(0) String? authorName,
      @JsonKey(name: "author_url") @HiveField(1) String? authorUrl,
      @HiveField(2) String? language,
      @JsonKey(name: "original_language")
      @HiveField(3)
      String? originalLanguage,
      @JsonKey(name: "profile_photo_url") @HiveField(4) String? profilePhotoUrl,
      @HiveField(5) int? rating,
      @JsonKey(name: "relative_time_description")
      @HiveField(6)
      String? relativeTimeDescription,
      @HiveField(7) String? text,
      @HiveField(8) int? time,
      @HiveField(9) bool? translated});
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
    Object? originalLanguage = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? relativeTimeDescription = freezed,
    Object? text = freezed,
    Object? time = freezed,
    Object? translated = freezed,
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
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
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
      translated: freezed == translated
          ? _value.translated
          : translated // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      {@JsonKey(name: "author_name") @HiveField(0) String? authorName,
      @JsonKey(name: "author_url") @HiveField(1) String? authorUrl,
      @HiveField(2) String? language,
      @JsonKey(name: "original_language")
      @HiveField(3)
      String? originalLanguage,
      @JsonKey(name: "profile_photo_url") @HiveField(4) String? profilePhotoUrl,
      @HiveField(5) int? rating,
      @JsonKey(name: "relative_time_description")
      @HiveField(6)
      String? relativeTimeDescription,
      @HiveField(7) String? text,
      @HiveField(8) int? time,
      @HiveField(9) bool? translated});
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
    Object? originalLanguage = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? relativeTimeDescription = freezed,
    Object? text = freezed,
    Object? time = freezed,
    Object? translated = freezed,
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
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
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
      translated: freezed == translated
          ? _value.translated
          : translated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl(
      {@JsonKey(name: "author_name") @HiveField(0) required this.authorName,
      @JsonKey(name: "author_url") @HiveField(1) required this.authorUrl,
      @HiveField(2) required this.language,
      @JsonKey(name: "original_language")
      @HiveField(3)
      required this.originalLanguage,
      @JsonKey(name: "profile_photo_url")
      @HiveField(4)
      required this.profilePhotoUrl,
      @HiveField(5) required this.rating,
      @JsonKey(name: "relative_time_description")
      @HiveField(6)
      required this.relativeTimeDescription,
      @HiveField(7) required this.text,
      @HiveField(8) required this.time,
      @HiveField(9) required this.translated});

  factory _$ReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewModelImplFromJson(json);

  @override
  @JsonKey(name: "author_name")
  @HiveField(0)
  final String? authorName;
  @override
  @JsonKey(name: "author_url")
  @HiveField(1)
  final String? authorUrl;
  @override
  @HiveField(2)
  final String? language;
  @override
  @JsonKey(name: "original_language")
  @HiveField(3)
  final String? originalLanguage;
  @override
  @JsonKey(name: "profile_photo_url")
  @HiveField(4)
  final String? profilePhotoUrl;
  @override
  @HiveField(5)
  final int? rating;
  @override
  @JsonKey(name: "relative_time_description")
  @HiveField(6)
  final String? relativeTimeDescription;
  @override
  @HiveField(7)
  final String? text;
  @override
  @HiveField(8)
  final int? time;
  @override
  @HiveField(9)
  final bool? translated;

  @override
  String toString() {
    return 'ReviewModel(authorName: $authorName, authorUrl: $authorUrl, language: $language, originalLanguage: $originalLanguage, profilePhotoUrl: $profilePhotoUrl, rating: $rating, relativeTimeDescription: $relativeTimeDescription, text: $text, time: $time, translated: $translated)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel(
      {@JsonKey(name: "author_name")
      @HiveField(0)
      required final String? authorName,
      @JsonKey(name: "author_url")
      @HiveField(1)
      required final String? authorUrl,
      @HiveField(2) required final String? language,
      @JsonKey(name: "original_language")
      @HiveField(3)
      required final String? originalLanguage,
      @JsonKey(name: "profile_photo_url")
      @HiveField(4)
      required final String? profilePhotoUrl,
      @HiveField(5) required final int? rating,
      @JsonKey(name: "relative_time_description")
      @HiveField(6)
      required final String? relativeTimeDescription,
      @HiveField(7) required final String? text,
      @HiveField(8) required final int? time,
      @HiveField(9) required final bool? translated}) = _$ReviewModelImpl;

  factory _ReviewModel.fromJson(Map<String, dynamic> json) =
      _$ReviewModelImpl.fromJson;

  @override
  @JsonKey(name: "author_name")
  @HiveField(0)
  String? get authorName;
  @override
  @JsonKey(name: "author_url")
  @HiveField(1)
  String? get authorUrl;
  @override
  @HiveField(2)
  String? get language;
  @override
  @JsonKey(name: "original_language")
  @HiveField(3)
  String? get originalLanguage;
  @override
  @JsonKey(name: "profile_photo_url")
  @HiveField(4)
  String? get profilePhotoUrl;
  @override
  @HiveField(5)
  int? get rating;
  @override
  @JsonKey(name: "relative_time_description")
  @HiveField(6)
  String? get relativeTimeDescription;
  @override
  @HiveField(7)
  String? get text;
  @override
  @HiveField(8)
  int? get time;
  @override
  @HiveField(9)
  bool? get translated;
  @override
  @JsonKey(ignore: true)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
