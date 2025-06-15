// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:gradproject/models/prescription_model.dart';
import 'package:http/http.dart' as http;

class Getprescription {
  Future<PrescriptionModel> getPrescription({required String doctorId}) async {
    http.Response response = await http
        .get(Uri.parse('https://doctorz.onrender.com/api/v1/prescription/$doctorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return PrescriptionModel.fromJson(data);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }
}
