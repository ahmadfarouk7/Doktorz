class PatientAppointemetDetails {
  dynamic doctorName;
  dynamic specialization;
  dynamic date;
  dynamic time;
  dynamic photo;
  dynamic id;
  PatientAppointemetDetails({
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.photo,
     required this.id,
  });

  factory PatientAppointemetDetails.fromJson(json) {
    return PatientAppointemetDetails(
      doctorName: json['doctorId']['fullName'],
      specialization: json['doctorId']['specialization'],
      photo: json['doctorId']['photo'],
      id: json['doctorId']['_id'],
      date: json['date'],
      time: json['time'],
    );
  }
}
