import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  String? cId;
  String? name;
  String? image;
  String? description;

  CategoryModel({
    required this.cId,
    required this.name,
    required this.image,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      cId: json["cId"],
      name: json["name"],
      image: json["image"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cId": cId,
      "name": name,
      "image": image,
      "description": description,
    };
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
