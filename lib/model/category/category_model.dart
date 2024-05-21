import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';

@freezed
@immutable
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String? cId,
    required String? name,
    required List<String>? types, // List<String>?
    required String? image,
    required IconData? icon,
    required String? description,
  }) = _CategoryModel;
}
