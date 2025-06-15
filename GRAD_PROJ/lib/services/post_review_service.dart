// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/pref.dart';
import 'package:http/http.dart' as http;

class PostReview {
  Future<Map<String, dynamic>> postReview({
    required String id,
    required String review,
    required num rating,
  }) async {
    String? token =  await Prefs.getString('token');
    http.Response response = await http.post(
      Uri.parse('https://doctorz.onrender.com/api/v1/doctors/$id/reviews'),
      body: jsonEncode(
        {
          "review": review,
          "rating": rating,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return data;
  }
}
