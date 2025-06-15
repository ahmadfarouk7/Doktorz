class DoctorAppointemetDetails {
  dynamic userName;
  dynamic date;
  dynamic time;
  dynamic photo;
  dynamic id;
  DoctorAppointemetDetails(
      {required this.userName,
      required this.date,
      required this.time,
      required this.photo,
      required this.id,});

  factory DoctorAppointemetDetails.fromJson(json) {
    return DoctorAppointemetDetails(
      userName: json['userId']['fullName'],
      photo: json['userId']['photo'],
      id: json['userId']['_id'],
      date: json['date'],
      time: json['time'],
    );
  }
}
