import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:novoy/model/place_model.dart';

class VisitedPlaces extends Equatable {
  PlaceModel? place;
  Timestamp? visitDate;

  VisitedPlaces({
    this.place,
    this.visitDate,
  });

  factory VisitedPlaces.fromJson(Map<String, dynamic> json) {
    return VisitedPlaces(
      place: json['place'] != null ? PlaceModel.fromJson(json['place']) : null,
      visitDate: json['visitDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place?.toJson(),
      'visitDate': visitDate,
    };
  }

  VisitedPlaces copyWith({
    PlaceModel? place,
    Timestamp? visitDate,
  }) {
    return VisitedPlaces(
      place: place ?? this.place,
      visitDate: visitDate ?? this.visitDate,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [place, visitDate];
}
