// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return _BlogModel.fromJson(json);
}

/// @nodoc
mixin _$BlogModel {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get experience => throw _privateConstructorUsedError;
  List<String>? get image => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;
  DateTime? get updatedDate => throw _privateConstructorUsedError;
  UserModel get author => throw _privateConstructorUsedError;
  int? get like => throw _privateConstructorUsedError;
  List<PlaceModel>? get places => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlogModelCopyWith<BlogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogModelCopyWith<$Res> {
  factory $BlogModelCopyWith(BlogModel value, $Res Function(BlogModel) then) =
      _$BlogModelCopyWithImpl<$Res, BlogModel>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? experience,
      List<String>? image,
      DateTime? createdDate,
      DateTime? updatedDate,
      UserModel author,
      int? like,
      List<PlaceModel>? places});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$BlogModelCopyWithImpl<$Res, $Val extends BlogModel>
    implements $BlogModelCopyWith<$Res> {
  _$BlogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? experience = freezed,
    Object? image = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? author = null,
    Object? like = freezed,
    Object? places = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int?,
      places: freezed == places
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<PlaceModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BlogModelImplCopyWith<$Res>
    implements $BlogModelCopyWith<$Res> {
  factory _$$BlogModelImplCopyWith(
          _$BlogModelImpl value, $Res Function(_$BlogModelImpl) then) =
      __$$BlogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? experience,
      List<String>? image,
      DateTime? createdDate,
      DateTime? updatedDate,
      UserModel author,
      int? like,
      List<PlaceModel>? places});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$$BlogModelImplCopyWithImpl<$Res>
    extends _$BlogModelCopyWithImpl<$Res, _$BlogModelImpl>
    implements _$$BlogModelImplCopyWith<$Res> {
  __$$BlogModelImplCopyWithImpl(
      _$BlogModelImpl _value, $Res Function(_$BlogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? experience = freezed,
    Object? image = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? author = null,
    Object? like = freezed,
    Object? places = freezed,
  }) {
    return _then(_$BlogModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int?,
      places: freezed == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<PlaceModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlogModelImpl implements _BlogModel {
  const _$BlogModelImpl(
      {required this.id,
      required this.title,
      required this.experience,
      required final List<String>? image,
      required this.createdDate,
      required this.updatedDate,
      required this.author,
      required this.like,
      required final List<PlaceModel>? places})
      : _image = image,
        _places = places;

  factory _$BlogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? experience;
  final List<String>? _image;
  @override
  List<String>? get image {
    final value = _image;
    if (value == null) return null;
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final UserModel author;
  @override
  final int? like;
  final List<PlaceModel>? _places;
  @override
  List<PlaceModel>? get places {
    final value = _places;
    if (value == null) return null;
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BlogModel(id: $id, title: $title, experience: $experience, image: $image, createdDate: $createdDate, updatedDate: $updatedDate, author: $author, like: $like, places: $places)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            const DeepCollectionEquality().equals(other._image, _image) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.like, like) || other.like == like) &&
            const DeepCollectionEquality().equals(other._places, _places));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      experience,
      const DeepCollectionEquality().hash(_image),
      createdDate,
      updatedDate,
      author,
      like,
      const DeepCollectionEquality().hash(_places));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogModelImplCopyWith<_$BlogModelImpl> get copyWith =>
      __$$BlogModelImplCopyWithImpl<_$BlogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogModelImplToJson(
      this,
    );
  }
}

abstract class _BlogModel implements BlogModel {
  const factory _BlogModel(
      {required final String? id,
      required final String? title,
      required final String? experience,
      required final List<String>? image,
      required final DateTime? createdDate,
      required final DateTime? updatedDate,
      required final UserModel author,
      required final int? like,
      required final List<PlaceModel>? places}) = _$BlogModelImpl;

  factory _BlogModel.fromJson(Map<String, dynamic> json) =
      _$BlogModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get experience;
  @override
  List<String>? get image;
  @override
  DateTime? get createdDate;
  @override
  DateTime? get updatedDate;
  @override
  UserModel get author;
  @override
  int? get like;
  @override
  List<PlaceModel>? get places;
  @override
  @JsonKey(ignore: true)
  _$$BlogModelImplCopyWith<_$BlogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
