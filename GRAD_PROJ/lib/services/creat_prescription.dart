import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:http/http.dart' as http;

class CreatPrescription {
  Future<Map<String, dynamic>> creatPrescription({
    required String userID,
    required String status,
    required List medications,
  }) async {
    http.Response response = await http.post(
        Uri.parse('https://doctorz.onrender.com/api/v1/prescription'),
        body: jsonEncode({
          "userID": userID,
          "status":status,
          "medications":medications,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return data;
  }
}
