import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:http/http.dart' as http;

class BookAppointementService {
  Future<Map<String, dynamic>> bookApoointemt({
    required String doctorId,
    required String userName,
    required dynamic time,
    required String phoneNumber,
    required dynamic date,
    required dynamic age,
  }) async {
    http.Response response = await http.post(
        Uri.parse('https://doctorz.onrender.com/api/v1/users/appointment'),
        body: jsonEncode({
          "doctorId": doctorId,
          "userId": kId!,
          "userName": userName,
          "time": time,
          "age": age,
          "phoneNumber": phoneNumber,
          "date": date
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
