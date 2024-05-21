class TripLocation {
  final String name;
  final String time;

  TripLocation({
    required this.name,
    required this.time,
  });

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      name: json["name"] ?? "",
      time: json["time"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "time": this.time,
    };
  }
}
