class GetAllDoctorsModel {
  dynamic fullName;
  dynamic photo;
  dynamic ratingAverage;
  dynamic startWorkingTime;
  dynamic endWorkingTime;
  dynamic id;
  dynamic ticketPrice;
  GetAllDoctorsModel({
    required this.fullName,
    required this.photo,
    required this.ratingAverage,
    required this.startWorkingTime,
    required this.endWorkingTime,
    required this.id,
    required this.ticketPrice,
  });
  factory GetAllDoctorsModel.fromJson(json) {
    return GetAllDoctorsModel(
        fullName: json['fullName'],
        photo: json['photo'],
        ratingAverage: json['ratingAverage'],
        startWorkingTime: json['startWorkingTime'],
        endWorkingTime: json['endWorkingTime'],
        id: json['_id'],
        ticketPrice: json['ticketPrice']);
  }
}
