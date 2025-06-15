import 'package:flutter/material.dart';
import 'package:gradproject/pref.dart';

const kColor = Color(0xff3d8888);
String? kToken = Prefs.getString('token');
String? kId = Prefs.getString('ID');
String? kRole = Prefs.getString('role');
String kName = Prefs.getString('name')!;
List kSpecialist = [
    'Cardiology',
    'Dermatology',
    'Orthopedics',
    'Oncology',
    'Neurology',
    'Pediatrics',
    'Gynecology',
    'Psychiatry',
    'Endocrinology',
    'Urology',
  ];
