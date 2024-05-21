// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripMemberModel _$TripMemberModelFromJson(Map<String, dynamic> json) {
  return _TripMemberModel.fromJson(json);
}

/// @nodoc
mixin _$TripMemberModel {
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get age => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripMemberModelCopyWith<TripMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripMemberModelCopyWith<$Res> {
  factory $TripMemberModelCopyWith(
          TripMemberModel value, $Res Function(TripMemberModel) then) =
      _$TripMemberModelCopyWithImpl<$Res, TripMemberModel>;
  @useResult
  $Res call(
      {String? name,
      String? email,
      String? phone,
      String? uId,
      String? gender,
      String? age});
}

/// @nodoc
class _$TripMemberModelCopyWithImpl<$Res, $Val extends TripMemberModel>
    implements $TripMemberModelCopyWith<$Res> {
  _$TripMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? uId = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripMemberModelImplCopyWith<$Res>
    implements $TripMemberModelCopyWith<$Res> {
  factory _$$TripMemberModelImplCopyWith(_$TripMemberModelImpl value,
          $Res Function(_$TripMemberModelImpl) then) =
      __$$TripMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? email,
      String? phone,
      String? uId,
      String? gender,
      String? age});
}

/// @nodoc
class __$$TripMemberModelImplCopyWithImpl<$Res>
    extends _$TripMemberModelCopyWithImpl<$Res, _$TripMemberModelImpl>
    implements _$$TripMemberModelImplCopyWith<$Res> {
  __$$TripMemberModelImplCopyWithImpl(
      _$TripMemberModelImpl _value, $Res Function(_$TripMemberModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? uId = freezed,
    Object? gender = freezed,
    Object? age = freezed,
  }) {
    return _then(_$TripMemberModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripMemberModelImpl implements _TripMemberModel {
  _$TripMemberModelImpl(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.gender,
      required this.age});

  factory _$TripMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripMemberModelImplFromJson(json);

  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? uId;
  @override
  final String? gender;
  @override
  final String? age;

  @override
  String toString() {
    return 'TripMemberModel(name: $name, email: $email, phone: $phone, uId: $uId, gender: $gender, age: $age)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripMemberModelImplCopyWith<_$TripMemberModelImpl> get copyWith =>
      __$$TripMemberModelImplCopyWithImpl<_$TripMemberModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripMemberModelImplToJson(
      this,
    );
  }
}

abstract class _TripMemberModel implements TripMemberModel {
  factory _TripMemberModel(
      {required final String? name,
      required final String? email,
      required final String? phone,
      required final String? uId,
      required final String? gender,
      required final String? age}) = _$TripMemberModelImpl;

  factory _TripMemberModel.fromJson(Map<String, dynamic> json) =
      _$TripMemberModelImpl.fromJson;

  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get uId;
  @override
  String? get gender;
  @override
  String? get age;
  @override
  @JsonKey(ignore: true)
  _$$TripMemberModelImplCopyWith<_$TripMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
