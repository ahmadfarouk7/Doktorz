import 'dart:convert';

import 'package:gradproject/constants.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<dynamic> payment({required String id, required dynamic amount}) async {
    http.Response response = await http.post(
      Uri.parse(
        'https://doctorz.onrender.com/api/v1/payment/pay/$id',
      ),
      body: jsonEncode(
        {
          'amount': amount,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $kToken',
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return data['paymentUrl'];
    } else {
      throw Exception('There was an error .... Try again');
    }
  }
}
