import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? gender;
  String? age;
  List<String> tripsIds = [];
  List<String> favPlacesIds = [];

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.gender,
    required this.age,
    this.tripsIds = const <String>[],
    this.favPlacesIds = const <String>[],
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    uId = json["uId"];
    gender = json["gender"];
    age = json["age"];
    tripsIds = json["tripsIds"] != null && json["tripsIds"].isNotEmpty
        ? List<String>.from(json["tripsIds"])
        : [];

    favPlacesIds =
        json["favPlacesIds"] != null && json["favPlacesIds"].isNotEmpty
            ? List<String>.from(json["favPlacesIds"])
            : [];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "gender": gender,
      "age": age,
      "tripsIds": tripsIds,
      "favPlacesIds": favPlacesIds,
    };
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        name,
        phone,
        uId,
        gender,
        age,
        tripsIds,
        favPlacesIds,
      ];
}
