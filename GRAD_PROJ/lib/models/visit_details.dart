class VisitsDetails {
  String name;
  String time;
  VisitsDetails({
    required this.name,
    required this.time,
  });
  factory VisitsDetails.fromJson(json) {
    return VisitsDetails(
      name: json['userName'],
      time: json['time'],
    );
  }
}
