// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:http/http.dart' as http;

class GetAllDoctorsService {
  Future<List<GetDoctorModel>> getAllDoctors() async {
    http.Response response = await http.get(
      Uri.parse('https://doctorz.onrender.com/api/v1/doctors'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      List<GetDoctorModel> doctors = [];
      for (int i = 0; i < data['results'] ; i++) {
        doctors.add(
          GetDoctorModel.fromJson(data['data']['data'][i]),
        );
      }
      print(doctors.length);
      return doctors;
    } else {
      throw Exception('There was an error');
    }
  }
}
