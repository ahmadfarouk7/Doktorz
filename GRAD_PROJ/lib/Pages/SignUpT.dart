// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Login.dart';
import 'package:gradproject/Pages/signup.dart';
import 'package:gradproject/Pages/verfiy_doctor_account.dart';
import 'package:gradproject/pref.dart';
import 'package:http/http.dart' as http;

class SignUpT extends StatefulWidget {
  final Map<String, dynamic> userData;

  const SignUpT({Key? key, required this.userData}) : super(key: key);

  @override
  State<SignUpT> createState() => _SignUpTState();
}

class _SignUpTState extends State<SignUpT> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool user = false;
  bool doctor = false;
  bool passwordVisible = false;
  bool conPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFF3D8888),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0, bottom: 25),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  ' Your signup process',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25, left: 35, bottom: 15, right: 35),
                      child: TextFormField(
                        controller: phoneNumberController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 35, bottom: 15, right: 35),
                      child: TextFormField(
                        obscureText: !passwordVisible,
                        controller: passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          labelText: 'Password',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 35, bottom: 25, right: 35),
                      child: TextFormField(
                        obscureText: !conPasswordVisible,
                        controller: confirmPasswordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(conPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  conPasswordVisible = !conPasswordVisible;
                                },
                              );
                            },
                          ),
                          labelText: 'Confirm Password',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Position :',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: const Color(0xFF3D8888),
                        activeColor: Colors.white,
                        value: user,
                        onChanged: (bool? value) {
                          setState(() {
                            user = value ??
                                false; // Update isChecked1 when the first checkbox is changed
                          });
                        },
                      ),
                      const Text(
                        'patient',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: const Color(0xFF3D8888),
                          activeColor: Colors.white,
                          value: doctor,
                          onChanged: (bool? value) {
                            setState(() {
                              doctor = value ??
                                  false; // Update isChecked2 when the second checkbox is changed
                            });
                          },
                        ),
                        const Text(
                          'doctor',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: ElevatedButton(
                      onPressed: () {
                        if (user) {
                          signUp();
                        } else {
                          Map<String, dynamic> userData = {
                            'fullName': widget.userData['fullName'],
                            'email': widget.userData['email'],
                            'gender': widget.userData['gender'],
                            'age': widget.userData['age'],
                            'phoneNumber': phoneNumberController.text,
                            'password': passwordController.text,
                            'confirmPassword': confirmPasswordController.text,
                          };
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VerifyDoctorAccount(
                                data: userData,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(203, 203, 203, 0.38),
                        minimumSize: const Size(130, 40),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(203, 203, 203, 0.38),
                        minimumSize: const Size(130, 40),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Color(0xFFFFF400),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() {
    // Extract user data
    String fullName = widget.userData['fullName'];
    String email = widget.userData['email'];
    String gender = widget.userData['gender'];
    int age = widget.userData['age'];
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;
    String confirmPass = confirmPasswordController.text;

    // Determine userType based on checkbox selection
    String userType;
    if (user) {
      userType = 'user';
    } else if (doctor) {
      userType = 'doctor';
    } else {
      // If neither checkbox is selected, set userType to 'user' as a fallback
      userType = 'doctor';
    }

    // Convert userType to lowercase
    userType = userType.toLowerCase();

    // Send sign-up request to the API
    http
        .post(
      Uri.parse('https://doctorz.onrender.com/api/v1/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'fullName': fullName,
        'email': email,
        'gender': gender,
        'age': age,
        'phoneNumber': phoneNumber,
        'password': password,
        'passwordConfirm': confirmPass,
        'userType': userType,
      }),
    )
        .then((response) {
      var data = jsonDecode(response.body);
      print(data);
      if (data['status'] == 'success') {
        Prefs.setString('ID', data['data']['user']['_id']);
        Prefs.setString('token', data['token']);
        print('idd ${Prefs.getString('ID')}');
        print('token ${Prefs.getString('token')}');
        // If sign-up is successful, navigate to appropriate page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Success'),
          ),
        );
      } else {
        // If sign-up fails, display error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-up failed. Please try again.'),
          ),
        );
      }
    }).catchError((error) {
      // If an error occurs during sign-up, display error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while signing up.'),
        ),
      );
    });
  }
}
