// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Change_ok.dart';
import 'package:gradproject/pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  bool _isPasswordValid = false;

  bool _isMinLengthChecked = false;
  bool _isUpperCaseChecked = false;
  bool _isLowerCaseChecked = false;
  bool _isSpecialCharChecked = false;
  bool _isNumberChecked = false;

  void _validatePassword(String value) {
    // Regular expressions to check for password requirements
    RegExp lengthRegEx = RegExp(r'.{8,}');
    RegExp upperCaseRegEx = RegExp(r'[A-Z]');
    RegExp lowerCaseRegEx = RegExp(r'[a-z]');
    RegExp numberRegEx = RegExp(r'[0-9]');
    RegExp specialCharRegEx = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    setState(() {
      _isPasswordValid = lengthRegEx.hasMatch(value) &&
          upperCaseRegEx.hasMatch(value) &&
          lowerCaseRegEx.hasMatch(value) &&
          numberRegEx.hasMatch(value) &&
          specialCharRegEx.hasMatch(value);

      _isMinLengthChecked = lengthRegEx.hasMatch(value);
      _isUpperCaseChecked = upperCaseRegEx.hasMatch(value);
      _isLowerCaseChecked = lowerCaseRegEx.hasMatch(value);
      _isSpecialCharChecked = specialCharRegEx.hasMatch(value);
      _isNumberChecked = numberRegEx.hasMatch(value);
    });
  }

  Future<void> updatePassword() async {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Retrieve authentication token from preferences
    String? authToken = Prefs.getString('token');

    if (authToken == null) {
      // If authentication token is null, user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are not logged in! Please log in to get access.'),
        ),
      );
      return;
    }

    final url =
        Uri.parse('https://doctorz.onrender.com/api/v1/auth/updateMyPassword');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    final body = jsonEncode({
      "passwordCurrent": currentPassword,
      "password": newPassword,
      "passwordConfirm": confirmPassword
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const passChanged()),
        );
      } else {
        // Failed to update password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update password. Please try again.'),
          ),
        );
      }
    } catch (error) {
      // An error occurred while updating password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while updating password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 35.0,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3E8989)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3E8989)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3E8989)),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showCurrentPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showCurrentPassword = !_showCurrentPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showCurrentPassword,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showNewPassword = !_showNewPassword;
                        });
                      },
                    ),
                    suffix: _showNewPassword
                        ? Icon(
                            _isPasswordValid
                                ? Icons.check_circle
                                : Icons.error_outline,
                            color: _isPasswordValid
                                ? const Color(0xff3E8989)
                                : Colors.red,
                          )
                        : null,
                  ),
                  obscureText: !_showNewPassword,
                  onChanged: _validatePassword,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showConfirmPassword,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Password should contain :',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isMinLengthChecked,
                      onChanged: null,
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(_isMinLengthChecked
                          ? const Color(0xff3E8989)
                          : Colors.grey),
                      shape: const CircleBorder(),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Min 8 characters',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isUpperCaseChecked,
                      onChanged: null,
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(_isUpperCaseChecked
                          ? const Color(0xff3E8989)
                          : Colors.grey),
                      shape: const CircleBorder(),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Upper case letter',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isLowerCaseChecked,
                      onChanged: null,
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(_isLowerCaseChecked
                          ? const Color(0xff3E8989)
                          : Colors.grey),
                      shape: const CircleBorder(),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Lower case letter',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isSpecialCharChecked,
                      onChanged: null,
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(_isSpecialCharChecked
                          ? const Color(0xff3E8989)
                          : Colors.grey),
                      shape: const CircleBorder(),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Special character',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isNumberChecked,
                      onChanged: null,
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(_isNumberChecked
                          ? const Color(0xff3E8989)
                          : Colors.grey),
                      shape: const CircleBorder(),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Number',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  onPressed: _isPasswordValid ? updatePassword : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 50), // Adjust the width
                    backgroundColor: _isPasswordValid
                        ? const Color(0xff3E8989)
                        : Colors.red, // Change color to red
                  ),
                  child: const Text(
                    'Update Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
