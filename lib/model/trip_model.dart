import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:novoy/model/visited_places_model.dart';

class TripModel {
  final String name;
  final String startdate;
  final String enddate;
  final String destination;

  TripModel({
    required this.name,
    required this.startdate,
    required this.enddate,
    required this.destination,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      name: json["name"] ?? "",
      startdate: json["startdate"] ?? "",
      enddate: json["enddate"] ?? "",
      destination: json["destination"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "startdate": this.startdate,
      "enddate": this.enddate,
      "destination": this.destination,
    };
  }
}

class TripModelN extends Equatable {
  String? tripId;
  String? uId;
  String? name;
  List<String>? destinationsIds = [];
  Timestamp? createOn;
  List<String>? users = [];
  List<TripDestination>? destinations;

  TripModelN({
    required this.tripId,
    required this.uId,
    required this.name,
    required this.destinationsIds,
    required this.createOn,
    required this.users,
    this.destinations = const [],
  });

  factory TripModelN.fromJson(Map<String, dynamic> json) {
    List<dynamic>? users = json["users"];
    List<dynamic>? destinations = json["destinationsIds"];
    return TripModelN(
      tripId: json["tripId"] ?? "",
      uId: json["uId"] ?? "",
      name: json["name"] ?? "",
      destinationsIds: destinations != null && destinations.isNotEmpty
          ? List<String>.from(destinations)
          : [],
      createOn: json["createOn"] ?? "",
      users: users != null && users.isNotEmpty ? List<String>.from(users) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tripId": this.tripId,
      "uId": this.uId,
      "name": this.name,
      "destinationsIds": this.destinationsIds,
      "createOn": this.createOn,
      "users": this.users,
    };
  }

  // copyWith

  TripModelN copyWith({
    String? tripId,
    String? uId,
    String? name,
    List<String>? destinationsIds,
    Timestamp? createOn,
    List<String>? users,
    List<TripDestination>? destinations,
  }) {
    return TripModelN(
      tripId: tripId ?? this.tripId,
      uId: uId ?? this.uId,
      name: name ?? this.name,
      destinationsIds: destinationsIds ?? this.destinationsIds,
      createOn: createOn ?? this.createOn,
      users: users ?? this.users,
      destinations: destinations ?? this.destinations,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [
        tripId,
        uId,
        name,
        destinationsIds,
        createOn,
        users,
      ];
}

class TripDestination extends Equatable {
  String? destinationId;
  String? tripId;
  String? createdUid;
  String? name;
  String? comment;
  Timestamp? startDate;
  Timestamp? leaveDate;
  String? description;
  List<String>? image;
  GeoPoint? location;
  List<VisitedPlaces>? visitedPlaces = [];

  TripDestination({
    required this.destinationId,
    required this.tripId,
    required this.createdUid,
    required this.name,
    required this.comment,
    required this.startDate,
    required this.leaveDate,
    required this.description,
    required this.image,
    required this.location,
    required this.visitedPlaces,
  });

  factory TripDestination.fromJson(Map<String, dynamic> json) {
    List<dynamic>? image = json["image"];
    return TripDestination(
      destinationId: json["destinationId"] ?? "",
      tripId: json["tripId"] ?? "",
      createdUid: json["createdUid"] ?? "",
      name: json["name"] ?? "",
      comment: json["comment"] ?? "",
      startDate: json["startDate"] ?? "",
      leaveDate: json["leaveDate"] ?? "",
      description: json["description"] ?? "",
      image: image != null && image.isNotEmpty ? List<String>.from(image) : [],
      location: json["location"] ?? "",
      visitedPlaces: json["visitedPlaces"] != null
          ? List<VisitedPlaces>.from(
              json["visitedPlaces"].map((x) => VisitedPlaces.fromJson(x)),)
          : [],
      // visitedPlaces: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "destinationId": this.destinationId,
      "tripId": this.tripId,
      "createdUid": this.createdUid,
      "name": this.name,
      "comment": this.comment,
      "startDate": this.startDate,
      "leaveDate": this.leaveDate,
      "description": this.description,
      "image": this.image,
      "location": this.location,
      "visitedPlaces": this.visitedPlaces == null
          ? []
          : this.visitedPlaces?.map((e) => e.toJson()).toList(),
    };
  }

  // copyWith
  TripDestination copyWith({
    String? destinationId,
    String? tripId,
    String? createdUid,
    String? name,
    String? comment,
    Timestamp? startDate,
    Timestamp? leaveDate,
    String? description,
    List<String>? image,
    GeoPoint? location,
    List<VisitedPlaces>? visitedPlaces,
  }) {
    return TripDestination(
      destinationId: destinationId ?? this.destinationId,
      tripId: tripId ?? this.tripId,
      createdUid: createdUid ?? this.createdUid,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      startDate: startDate ?? this.startDate,
      leaveDate: leaveDate ?? this.leaveDate,
      description: description ?? this.description,
      image: image ?? this.image,
      location: location ?? this.location,
      visitedPlaces: visitedPlaces ?? this.visitedPlaces,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [
        destinationId,
        tripId,
        createdUid,
        name,
        comment,
        startDate,
        leaveDate,
        description,
        image,
        location,
        visitedPlaces,
      ];
}
