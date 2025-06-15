import 'package:flutter/material.dart';

class SettingsModel {
  final IconData icon;
  final String title;
  final IconData icon2;
  final Function(BuildContext)? onTap; // Define onTap function

  SettingsModel({
    required this.icon,
    required this.title,
    required this.icon2,
    this.onTap, // Include onTap parameter
  });
}
