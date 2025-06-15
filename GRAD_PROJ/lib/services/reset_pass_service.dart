import 'dart:convert';

import 'package:http/http.dart' as http;

class ResetPasswordService {
  Future<Map<String, dynamic>> restPassword(
      {required int otp,
      required String password,
      required String confirmPassword}) async {
    http.Response response = await http.patch(
      Uri.parse('https://doctorz.onrender.com/api/v1/auth/resetPassword'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "password": password,
          "passwordConfirm": confirmPassword,
          "OTP": otp,
        },
      ),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
