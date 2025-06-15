// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradproject/Pages/verfiy_pass_otp.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/services/forget_pass_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomAppBar(
                title: 'Forget Password',
              ),
              SvgPicture.asset(
                'assets/images/Twofactorauthentication-amico(3)2.svg',
              ),
              const SizedBox(height: 10),
              const Text(
                "Don't worry! That happens. Please enter the email address associated with your account and we will send you an email with confirmation to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'User@gmail.com',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 243, 235, 235),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 243, 235, 235),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 243, 235, 235),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onTap: () async {
                  print(email.text);
                  if (email.text.isNotEmpty) {
                    setState(() {
                      isloading = true;
                    });
                    var data = await ForgetPasswordServices()
                        .sendOTP(email: email.text);
                    setState(() {
                      isloading = false;
                    });
                    if (data['status'] == 'success') {
                      snackBar(context, content: data['resetOTP']);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Otp(
                            contact: email.text,
                            otp: data['resetOTP'],
                          ),
                        ),
                      );
                    } else {
                      snackBar(context,
                          content: data['message'], color: Colors.red);
                    }
                  } else {
                    snackBar(
                      context,
                      content: 'Please Enter Email',
                      color: Colors.red,
                    );
                  }
                },
                text: 'Confirm',
                isloading: isloading,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Remember Password?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xff3E8989),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void snackBar(BuildContext context,
      {required String content, Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(content)),
      backgroundColor: color,
    ));
  }
}
