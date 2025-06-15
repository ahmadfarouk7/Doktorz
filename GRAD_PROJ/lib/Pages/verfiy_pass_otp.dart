
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradproject/Pages/new_pass.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/Widgets/otp_field.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/styles.dart';

class Otp extends StatelessWidget {
  const Otp({super.key, required this.contact, required this.otp});
  final String contact;
  final String otp;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();
    TextEditingController controller4 = TextEditingController();
    TextEditingController controller5 = TextEditingController();
    TextEditingController controller6 = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'Verification Code', color: kColor),
            SvgPicture.asset(
              'assets/images/Emailcapture-amico(1)1.svg',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 27,
                ),
                const Text(
                  'Verify email address',
                  style: Styles.fontSize20,
                ),
                Image.asset('assets/images/freepik--message-icon--inject-3.png')
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'verification code sent for ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: contact,
                    style: const TextStyle(
                      color: kColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTPField(
                    controller: controller1,
                  ),
                  OTPField(
                    controller: controller2,
                  ),
                  OTPField(
                    controller: controller3,
                  ),
                  OTPField(
                    controller: controller4,
                  ),
                  OTPField(
                    controller: controller5,
                  ),
                  OTPField(
                    controller: controller6,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    String otpCode = controller1.text +
                        controller2.text +
                        controller3.text +
                        controller4.text +
                        controller5.text +
                        controller6.text;
                    print(controller1.text);
                    if (otp == otpCode) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewPassord(
                            otp: int.parse(otpCode),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(child: Text('OTP wrong')),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  text: 'Confirm Code',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '00:29   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' Resend Confirmation Code ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
