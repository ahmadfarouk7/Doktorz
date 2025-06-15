class UpdateDoctorModel {
  String fullName;
  String photo;
  UpdateDoctorModel({
    required this.fullName,
    required this.photo,
  });
  factory UpdateDoctorModel.fromjson(json) {
    return UpdateDoctorModel(
      fullName: json['fullName'],
      photo: json['photo'],
    );
  }
}