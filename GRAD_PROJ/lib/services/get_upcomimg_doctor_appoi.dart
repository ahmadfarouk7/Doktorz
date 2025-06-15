import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:gradproject/models/doctor_appoi_details.dart';
import 'package:http/http.dart' as http;

class GetUpComingDoctorAppointement {
  Future<List<dynamic>> getDoctorAppointement({required String id}) async {
    http.Response response = await http.get(
      Uri.parse('https://doctorz.onrender.com/api/v1/doctors/appointments/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $kToken',
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List appointements = [];
    print(data);
    if (data['status'] == 'success') {
      for (int i = 0; i < data['appointments'].length; i++) {
        appointements.add(DoctorAppointemetDetails.fromJson(data['appointments'][i]));
      }
      return appointements;
    } else {
      return [];
    }
  }
}
