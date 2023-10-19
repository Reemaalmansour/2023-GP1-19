import 'package:flutter/foundation.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? gender;
  String? age;


  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.gender,
    required this.age,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    uId = json["uId"];
    gender = json["gender"];
    age = json["age"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "gender": gender,
      "age": age,
    };
  }
}
