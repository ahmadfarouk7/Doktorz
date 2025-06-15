// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:gradproject/models/visit_details.dart';
import 'package:http/http.dart' as http;

class GetDoctorAppointement {
  Future<List<dynamic>> getDoctorAppointement({required dynamic date}) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://doctorz.onrender.com/api/v1/doctors/appointments/$kId/$date'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    List Appointements = [];
    print(data);
    if (data['status'] == 'success') {
      for (int i = 0; i < data['appointments'].length; i++) {
        Appointements.add(VisitsDetails.fromJson(data['appointments'][i]));
      }
      return Appointements;
    } else {
      return [];
    }
  }
}
