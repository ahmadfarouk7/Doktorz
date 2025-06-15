// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gradproject/models/review_model.dart';
import 'package:gradproject/pref.dart';
import 'package:http/http.dart' as http;

class GetAllReviewService {
  Future<List<ReviewModel>> getAllReview(
      {required String id}) async {
        String? token =  await Prefs.getString('token');
    http.Response response = await http.get(
        Uri.parse('https://doctorz.onrender.com/api/v1/doctors/$id/reviews'),
        headers: {
          'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
          });
    List<ReviewModel> reviews = [];
    //if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    for (int i = 0; i < data['data']['reviews'].length; i++) {
      reviews.add(ReviewModel.fromJson(data['data']['reviews'][i]));
    }
    return reviews;
    // } else {
    //   return [];
    // }
  }
}
