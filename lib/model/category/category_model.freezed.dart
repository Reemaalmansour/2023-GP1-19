// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryModel {
  String? get cId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<String>? get types =>
      throw _privateConstructorUsedError; // List<String>?
  String? get image => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
          CategoryModel value, $Res Function(CategoryModel) then) =
      _$CategoryModelCopyWithImpl<$Res, CategoryModel>;
  @useResult
  $Res call(
      {String? cId,
      String? name,
      List<String>? types,
      String? image,
      IconData? icon,
      String? description});
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res, $Val extends CategoryModel>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cId = freezed,
    Object? name = freezed,
    Object? types = freezed,
    Object? image = freezed,
    Object? icon = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      cId: freezed == cId
          ? _value.cId
          : cId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      types: freezed == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryModelImplCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$$CategoryModelImplCopyWith(
          _$CategoryModelImpl value, $Res Function(_$CategoryModelImpl) then) =
      __$$CategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? cId,
      String? name,
      List<String>? types,
      String? image,
      IconData? icon,
      String? description});
}

/// @nodoc
class __$$CategoryModelImplCopyWithImpl<$Res>
    extends _$CategoryModelCopyWithImpl<$Res, _$CategoryModelImpl>
    implements _$$CategoryModelImplCopyWith<$Res> {
  __$$CategoryModelImplCopyWithImpl(
      _$CategoryModelImpl _value, $Res Function(_$CategoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cId = freezed,
    Object? name = freezed,
    Object? types = freezed,
    Object? image = freezed,
    Object? icon = freezed,
    Object? description = freezed,
  }) {
    return _then(_$CategoryModelImpl(
      cId: freezed == cId
          ? _value.cId
          : cId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      types: freezed == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CategoryModelImpl implements _CategoryModel {
  const _$CategoryModelImpl(
      {required this.cId,
      required this.name,
      required final List<String>? types,
      required this.image,
      required this.icon,
      required this.description})
      : _types = types;

  @override
  final String? cId;
  @override
  final String? name;
  final List<String>? _types;
  @override
  List<String>? get types {
    final value = _types;
    if (value == null) return null;
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// List<String>?
  @override
  final String? image;
  @override
  final IconData? icon;
  @override
  final String? description;

  @override
  String toString() {
    return 'CategoryModel(cId: $cId, name: $name, types: $types, image: $image, icon: $icon, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryModelImpl &&
            (identical(other.cId, cId) || other.cId == cId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cId, name,
      const DeepCollectionEquality().hash(_types), image, icon, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      __$$CategoryModelImplCopyWithImpl<_$CategoryModelImpl>(this, _$identity);
}

abstract class _CategoryModel implements CategoryModel {
  const factory _CategoryModel(
      {required final String? cId,
      required final String? name,
      required final List<String>? types,
      required final String? image,
      required final IconData? icon,
      required final String? description}) = _$CategoryModelImpl;

  @override
  String? get cId;
  @override
  String? get name;
  @override
  List<String>? get types;
  @override // List<String>?
  String? get image;
  @override
  IconData? get icon;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
