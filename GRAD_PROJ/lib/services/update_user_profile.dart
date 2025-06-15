// ignore_for_file: await_only_futures

import 'dart:convert';
import 'package:gradproject/models/get_user_model.dart';
import 'package:gradproject/pref.dart';
import 'package:http/http.dart' as http;

class UpdateUserProfileServices {
  Future<dynamic> updateUserProfile(
      {required String photo,
      required String fullName,
      required String phoneNumber,
      required String email}) async {
    String? token = await Prefs.getString('token');
    http.Response response = await http
        .patch(Uri.parse('https://doctorz.onrender.com/api/v1/users/updateMe'),
            body: jsonEncode({
              'photo': photo,
              'fullName': fullName,
              'phoneNumber': phoneNumber,
              'email': email,
            }),
            headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 401) {
      throw Exception('You are not logged in, Please log in');
    } else if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return GetUserModel.fromjson(data);
    }
  }
}
