class GetUserModel {
  String fullName;
  String photo;
  String phoneNumber;
  String email;
  String gender;
  dynamic age;
  GetUserModel(
      {required this.fullName,
      required this.photo,
      required this.phoneNumber,
      required this.email,
      required this.gender,
      required this.age});
  factory GetUserModel.fromjson(json) {
    return GetUserModel(
        fullName: json['fullName'],
        photo: json['photo'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        gender: json['gender'],
        age:json['age']);
  }
}
