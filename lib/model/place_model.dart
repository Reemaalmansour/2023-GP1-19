import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  String? pId; // primary key
  String? name;
  String? address;
  String? description;
  String? image;
  List<String>? imageUrls;
  String? lat;
  String? lng;
  bool? isFav;

  PlaceModel({
    this.pId,
    required this.name,
    required this.address,
    required this.description,
    required this.image,
    required this.imageUrls,
    required this.lat,
    required this.lng,
    this.isFav = false,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      pId: json['pId'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      image: json['image'],
      imageUrls: json['imageUrl'] != null
          ? List<String>.from(json['imageUrl'])
          : <String>[], //json['imageUrl']
      lat: json['lat'],
      lng: json['lng'],
      isFav: json['isFav'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'name': name,
      'address': address,
      'description': description,
      'image': image,
      'imageUrl': imageUrls,
      'lat': lat,
      'lng': lng,
      'isFav': isFav,
    };
  }

  PlaceModel copyWith({
    String? pId,
    String? name,
    String? address,
    String? description,
    String? image,
    List<String>? imageUrl,
    String? lat,
    String? lng,
    bool? isFav,
  }) {
    return PlaceModel(
      pId: pId ?? this.pId,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      image: image ?? this.image,
      imageUrls: imageUrl ?? this.imageUrls,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isFav: isFav ?? this.isFav,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [
        pId,
        name,
        address,
        description,
        image,
        imageUrls,
        lat,
        lng,
        isFav,
      ];
}
