// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/Pages/doctor_view.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/Widgets/custom_text_field.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/services/reset_pass_service.dart';
import 'package:gradproject/styles.dart';

class NewPassord extends StatefulWidget {
  const NewPassord({super.key, required this.otp});
  final int otp;

  @override
  State<NewPassord> createState() => _NewPassordState();
}

class _NewPassordState extends State<NewPassord> {
  @override
  Widget build(BuildContext context) {
    var controllerPass = TextEditingController();
    var controllerConfirmPass = TextEditingController();
    bool isloading = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'New Password', color: kColor),
            SvgPicture.asset(
                'assets/images/Twofactorauthentication-amico(3)2.svg'),
            const Text(
              'New Password',
              style: Styles.fontSize20,
              textAlign: TextAlign.center,
            ),
            const Text(
              'please write your new password  ',
              style: Styles.fontSize14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              controller: controllerPass,
              text: 'New Password',
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              controller: controllerConfirmPass,
              text: 'Confirm Password',
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () async {
                    setState(() {
                      isloading = true;
                    });
                    var data = await ResetPasswordService().restPassword(
                        otp: widget.otp,
                        password: controllerPass.text,
                        confirmPassword: controllerConfirmPass.text);
                    setState(() {
                      isloading = false;
                    });
                    if (data['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                            child: Text('Password Successfully changed')),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorView(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(child: Text(data['message'])),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  text: 'Confirm Password',
                  isloading: isloading,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
