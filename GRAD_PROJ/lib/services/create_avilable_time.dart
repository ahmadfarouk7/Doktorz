import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:http/http.dart' as http;

class CreateAvilableTime {
  Future<dynamic> createAvilableTime(
      {required dynamic slotDuration,
      required List<dynamic> availability}) async {
    http.Response response = await http.post(
      Uri.parse('https://doctorz.onrender.com/api/v1/doctors/available-time'),
      body: jsonEncode(
        {
          'doctorId': kId,
          'slotDuration': slotDuration,
          'availability': availability,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $kToken',
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
