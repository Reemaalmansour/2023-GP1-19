// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoListModel _$TodoListModelFromJson(Map<String, dynamic> json) {
  return _TodoListModel.fromJson(json);
}

/// @nodoc
mixin _$TodoListModel {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  UserModel? get author => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;
  DateTime? get updatedDate => throw _privateConstructorUsedError;
  bool? get isCompleted => throw _privateConstructorUsedError;
  List<UserModel>? get assignees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoListModelCopyWith<TodoListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListModelCopyWith<$Res> {
  factory $TodoListModelCopyWith(
          TodoListModel value, $Res Function(TodoListModel) then) =
      _$TodoListModelCopyWithImpl<$Res, TodoListModel>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      UserModel? author,
      DateTime? createdDate,
      DateTime? updatedDate,
      bool? isCompleted,
      List<UserModel>? assignees});

  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$TodoListModelCopyWithImpl<$Res, $Val extends TodoListModel>
    implements $TodoListModelCopyWith<$Res> {
  _$TodoListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isCompleted = freezed,
    Object? assignees = freezed,
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
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      assignees: freezed == assignees
          ? _value.assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodoListModelImplCopyWith<$Res>
    implements $TodoListModelCopyWith<$Res> {
  factory _$$TodoListModelImplCopyWith(
          _$TodoListModelImpl value, $Res Function(_$TodoListModelImpl) then) =
      __$$TodoListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      UserModel? author,
      DateTime? createdDate,
      DateTime? updatedDate,
      bool? isCompleted,
      List<UserModel>? assignees});

  @override
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$$TodoListModelImplCopyWithImpl<$Res>
    extends _$TodoListModelCopyWithImpl<$Res, _$TodoListModelImpl>
    implements _$$TodoListModelImplCopyWith<$Res> {
  __$$TodoListModelImplCopyWithImpl(
      _$TodoListModelImpl _value, $Res Function(_$TodoListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isCompleted = freezed,
    Object? assignees = freezed,
  }) {
    return _then(_$TodoListModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      assignees: freezed == assignees
          ? _value._assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoListModelImpl implements _TodoListModel {
  const _$TodoListModelImpl(
      {this.id,
      this.title,
      this.author,
      this.createdDate,
      this.updatedDate,
      this.isCompleted,
      final List<UserModel>? assignees})
      : _assignees = assignees;

  factory _$TodoListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoListModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final UserModel? author;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final bool? isCompleted;
  final List<UserModel>? _assignees;
  @override
  List<UserModel>? get assignees {
    final value = _assignees;
    if (value == null) return null;
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TodoListModel(id: $id, title: $title, author: $author, createdDate: $createdDate, updatedDate: $updatedDate, isCompleted: $isCompleted, assignees: $assignees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality()
                .equals(other._assignees, _assignees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      createdDate,
      updatedDate,
      isCompleted,
      const DeepCollectionEquality().hash(_assignees));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoListModelImplCopyWith<_$TodoListModelImpl> get copyWith =>
      __$$TodoListModelImplCopyWithImpl<_$TodoListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoListModelImplToJson(
      this,
    );
  }
}

abstract class _TodoListModel implements TodoListModel {
  const factory _TodoListModel(
      {final String? id,
      final String? title,
      final UserModel? author,
      final DateTime? createdDate,
      final DateTime? updatedDate,
      final bool? isCompleted,
      final List<UserModel>? assignees}) = _$TodoListModelImpl;

  factory _TodoListModel.fromJson(Map<String, dynamic> json) =
      _$TodoListModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  UserModel? get author;
  @override
  DateTime? get createdDate;
  @override
  DateTime? get updatedDate;
  @override
  bool? get isCompleted;
  @override
  List<UserModel>? get assignees;
  @override
  @JsonKey(ignore: true)
  _$$TodoListModelImplCopyWith<_$TodoListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
