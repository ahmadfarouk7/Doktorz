import 'dart:convert';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:http/http.dart' as http;

class SerarchDoctorsService {
  Future<List<GetDoctorModel>> searchDoctors(
      {required String searchType, required dynamic value}) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://doctorz.onrender.com/api/v1/doctors?$searchType=$value'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<GetDoctorModel> doctors = [];
      for (int i = 0; i < data['results']; i++) {
        doctors.add(
          GetDoctorModel.fromJson(data['data']['data'][i]),
        );
      }

      // ignore: avoid_print
      print(doctors);
      return doctors;
    } else {
      throw Exception('There was an error');
    }
  }
}
