import 'dart:convert';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:http/http.dart' as http;

class UpdateDoctorProfileServices {
  Future<dynamic> updateDoctorProfile({
    required String photo,
    // required String fullName,
    required String about,
    required String hospital,
    required String city,
    required String area,
    required String specialization,
    required String achievements,
    required dynamic ticketPrice,
    required String phoneNumber,
    required dynamic yearsExperience,
  }) async {
    http.Response response = await http.patch(
        Uri.parse('https://doctorz.onrender.com/api/v1/doctors/updateMe'),
        body: jsonEncode({
          'photo': photo,
          // 'fullName': fullName,
          'about': about,
          'hospital': hospital,
          'city': city,
          'area': area,
          'specialization': specialization,
          'achievements': achievements,
          'ticketPrice': ticketPrice,
          'phoneNumber': phoneNumber,
          'yearsExperience':yearsExperience,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
    if (response.statusCode == 401) {
      throw Exception('You are not logged in, Please log in');
    } else if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return GetDoctorModel.fromJson(data);
    }
  }
}
