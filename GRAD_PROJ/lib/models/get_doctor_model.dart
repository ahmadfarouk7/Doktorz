class GetDoctorModel {
  dynamic fullName;
  dynamic photo;
  dynamic about;
  dynamic phoneNumber;
  dynamic specialization;
  dynamic ratingAverage;
  dynamic achievements;
  dynamic ticketPrice;
  dynamic hospital;
  dynamic city;
  dynamic area;
  dynamic startWorkingTime;
  dynamic endWorkingTime;
  dynamic id;
  dynamic yearsExperience;

  GetDoctorModel({
    required this.fullName,
    required this.photo,
    required this.ratingAverage,
    required this.about,
    required this.phoneNumber,
    required this.specialization,
    required this.achievements,
    required this.ticketPrice,
    required this.city,
    required this.area,
    required this.hospital,
    required this.startWorkingTime,
    required this.endWorkingTime,
    required this.id,
    required this.yearsExperience,
  });

  factory GetDoctorModel.fromJson(json) {
    return GetDoctorModel(
      fullName: json['fullName'],
      photo: json['photo'],
      ratingAverage: json['ratingAverage'],
      about: json['about'],
      phoneNumber: json['phoneNumber'],
      specialization: json['specialization'],
      achievements: json['achievements'],
      ticketPrice: json['ticketPrice'],
      city: json['city'],
      area: json['area'],
      hospital: json['hospital'],
      startWorkingTime: json['startWorkingTime'],
      endWorkingTime: json['endWorkingTime'],
      id: json['_id'],
      yearsExperience:json['yearsExperience'],
    );
  }
}
