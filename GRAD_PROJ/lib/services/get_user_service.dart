import 'dart:convert';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_user_model.dart';
import 'package:http/http.dart' as http;

class GetUserService {
  Future<GetUserModel> getUser() async {
    http.Response response = await http.get(Uri.parse(
        'https://doctorz.onrender.com/api/v1/users/me'),headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kToken',
        });
        print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return GetUserModel.fromjson(data['data']['data']);
    }else{
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }
}