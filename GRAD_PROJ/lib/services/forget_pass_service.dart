import 'dart:convert';

import 'package:http/http.dart' as http;

class ForgetPasswordServices {
  Future<Map<String, dynamic>> sendOTP({required String email}) async {
    http.Response response = await http.post(
      Uri.parse('https://doctorz.onrender.com/api/v1/auth/forgotPassword'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'email': email,
        },
      ),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    // ignore: avoid_print
    print(data);
    return data;
    // if (response.statusCode == 200) {
    //   return data['resetOTP'];
    // } else {
    //   return data['message'];
    // }
  }
}
