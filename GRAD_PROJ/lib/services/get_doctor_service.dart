// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/models/get_doctor_model.dart';
import 'package:http/http.dart' as http;

class GetDoctorService {
  Future<GetDoctorModel> getDoctor({
    required String id,
  }) async {
    http.Response response = await http
        .get(Uri.parse('https://doctorz.onrender.com/api/v1/doctors/$id'));
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return GetDoctorModel.fromJson(data['data']['data']);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }
}
