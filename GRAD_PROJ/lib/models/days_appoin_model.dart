class DaysAppointement {
  String dayOfWeek;
  dynamic startTime;
  dynamic endTime;

  DaysAppointement({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime':endTime,
    };
  }
}
