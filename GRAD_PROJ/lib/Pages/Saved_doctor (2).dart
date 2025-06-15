// ignore_for_file: unused_field, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradproject/Pages/all_doctors2%20(3).dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:http/http.dart' as http;

class SavedDoctors extends StatefulWidget {
  const SavedDoctors({super.key});

  @override
  State<SavedDoctors> createState() => _SavedDoctorsState();
}

class _SavedDoctorsState extends State<SavedDoctors> {
  Future<List<GetDoctorModel>>? _savedDoctors;

  @override
  void initState() {
    super.initState();
    _getSavedDoctors();
  }

  Future<List<GetDoctorModel>> _getSavedDoctors() async {
    var patientId = kId;
    if (patientId != null) {
      // Assuming the API requires a token in the Authorization header
      var token = kToken;

      final response = await http.get(
        Uri.parse(
            'https://doctorz.onrender.com/api/v1/users/bookmarkedDoctors'),
        headers: {
          'Authorization': 'Bearer $token'
        }, // Add the token header if required
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<GetDoctorModel> saved = [];
        Map<String, dynamic> data = jsonDecode(response.body);
        print(jsonDecode(response.body));
        for (int i = 0; i < data['data']['length']; i++) {
          saved.add(
              GetDoctorModel.fromJson(data['data']['user']['savedDoctors'][i]));
        }
        return saved;
      } else {
        // Handle API errors, including unauthorized access (401)
        if (response.statusCode == 401) {
          throw Exception(
              'Unauthorized access. Please check your token or credentials.');
        } else {
          throw Exception(
              'Error getting saved doctors: ${response.statusCode}');
        }
      }
    } else {
      // Handle case where patient ID is not found
      throw Exception('Patient ID not found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<GetDoctorModel>>(
          future: _getSavedDoctors(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doctors = snapshot.data!;
              if (doctors.isEmpty) {
                return const Center(child: Text('No saved doctors yet.'));
              }
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) => DoctorCard(
                  doctorsModel: doctors[index],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
