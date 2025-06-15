import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:http/http.dart' as http;

class GetAvilableTime {
  Future<List<dynamic>> getAviliableTime(
      {required String id, required dynamic date}) async {
    http.Response response = await http.get(
        Uri.parse(
            'https://doctorz.onrender.com/api/v1/users/getAvailableTimeSlots/$id?date=$date'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 'success') {
      return data['availableSlots'];
    } else {
      return [];
    }
  }
}
