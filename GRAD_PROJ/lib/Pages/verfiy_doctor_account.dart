
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/Pages/verfiy_methods.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';

class VerifyDoctorAccount extends StatelessWidget {
  const VerifyDoctorAccount({super.key,required this.data});
  final Map<String,dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Verify Account',
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Expanded(
                  child: Text(
                    'these requests are in order to confirm whether you are an actual doctor or not out of concern for the safety of patients',
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/images/Search-amico1.svg',
            ),
            CustomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  VerifyMehods(doctorData: data,),
                  ),
                );
              },
              text: 'Go to verify the Account',
            ),
          ],
        ),
      ),
    );
  }
}
