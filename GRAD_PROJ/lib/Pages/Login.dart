// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradproject/Pages/doctor_view.dart';
import 'package:gradproject/Pages/forget_pass_view.dart';
import 'package:gradproject/Pages/patient_home.dart';
import 'package:gradproject/Pages/signup.dart';
import 'package:gradproject/pref.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool passwordVisible = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFF3D8888),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Transform.translate(
                offset: const Offset(-50, 100.0),
                child: const Text(
                  "Welcome Back! ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Transform.translate(
                offset: const Offset(-18, 100.0),
                child: const Text(
                  " Let's join us, we are waiting for you.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170.0, left: 30, right: 30),
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.white,

                  style: const TextStyle(
                      color: Colors.white), // Set text color to white
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(
                        color: Colors.white), // Set label color to white
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
                child: TextField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  obscureText: !passwordVisible,
                  style: const TextStyle(
                      color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: const TextStyle(
                        color: Colors.white), // Set label color to white
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: Color(0xFFFFF400), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // Get the email and password from the text fields
                      String email = emailController.text;
                      String password = passwordController.text;
                      // Send a POST request to the login API endpoint
                      http
                          .post(
                        Uri.parse(
                            'https://doctorz.onrender.com/api/v1/auth/login'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'email': email,
                          'password': password,
                        }),
                      )
                          .then((response) {
                        // Check if the login was successful
                        Map<String, dynamic> data = jsonDecode(response.body);
                        print(data);
                        if (response.statusCode == 200) {
                          Prefs.setString('token', data['token']);
                          Prefs.setString('ID', data['data']['user']['_id']);
                          Prefs.setString('role', data['userType']);
                          Prefs.setString(
                              'name', data['data']['user']['fullName']);
                          Prefs.setString(
                              'email', data['data']['user']['email']);
                          print(Prefs.getString('token'));
                          print(Prefs.getString('ID'));
                          // Navigate to the next screen (replace SignUpT with the appropriate screen)
                          if (data['userType'] == 'doctor') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DoctorView()),
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePatient()));
                          }
                        } else {
                          // Display an error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Login failed. Please check your credentials.'),
                            ),
                          );
                        }
                      }).catchError((error) {
                        // Display an error messag
                        //e to the user
                        print('An error occurred while logging in.');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('An error occurred while logging in.'),
                          ),
                        );
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Color(0xFF3D8888),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Don’t have an Account yet ?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Expanded(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              color: Color(0xFFFFF400),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              // const Text(
              //   'Or login with',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600),
              // ),
              // const SizedBox(
              //   height: 25,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: Colors.white,
              //       ),
              //       padding: const EdgeInsets.all(5),
              //       child: const Icon(
              //         Icons.facebook,
              //         size: 40,
              //         color: Colors.blue,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     GestureDetector(
              //       onTap: () async {
              //         // http.Response response = await http.get(Uri.parse(
              //         //     'https://doctorz.onrender.com/auth/google/callback'));
              //         // var data = jsonDecode(response.body);
              //         // print(data);
              //         // if (response.statusCode == 200) {
              //         //   if (data['userType'] == 'doctor') {
              //         //     Navigator.push(
              //         //       context,
              //         //       MaterialPageRoute(
              //         //           builder: (context) => const DoctorView()),
              //         //     );
              //         //   } else {
              //         //     Navigator.push(
              //         //         context,
              //         //         MaterialPageRoute(
              //         //             builder: (context) => const HomePatient()));
              //         //   }
              //         // } else {
              //         //   ScaffoldMessenger.of(context).showSnackBar(
              //         //     SnackBar(content: data['message']),
              //         //   );
              //         // }
              //         try {
              //           final GoogleSignInAccount? googleUser =
              //               await _googleSignIn.signIn();
              //           if (googleUser != null) {
              //             // Signed in successfully, navigate to your desired screen or perform other actions
              //             print('User signed in: ${googleUser.displayName}');
              //             // Navigate to your desired screen
              //             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
              //           } else {
              //             // User canceled the sign-in process
              //             print('User canceled sign-in');
              //           }
              //         } catch (error) {
              //           // Handle sign-in errors
              //           print('Error signing in: $error');
              //           // Show error message to the user if needed
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //               content: Text(
              //                   'Failed to sign in with Google. Please try again later.'),
              //             ),
              //           );
              //         }
              //       },
              //       child: Container(
              //           height: 48,
              //           width: 48,
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.white,
              //           ),
              //           padding: const EdgeInsets.all(5),
              //           child: Image.asset('assets/images/google.png')),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
