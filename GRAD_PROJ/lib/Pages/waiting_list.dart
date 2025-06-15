
import 'package:flutter/material.dart';
import 'package:gradproject/Pages/patient_today_appointement.dart';
import 'package:gradproject/Widgets/custom_button.dart';

class WaitingList extends StatelessWidget {
  const WaitingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 30,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff84F2A7),
              Color(0xff7DEB88),
              Color(0xff59C6AC),
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Waiting List',
              style: TextStyle(
                color: Color(0xff0C6464),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const WaitingCounter(
              color: Color(0xff4EC48B),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Reminder appointment will be start after three patient',
              style: TextStyle(
                color: Color(0xff0C6464),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset('assets/images/waiting.png'),
            const Spacer(),
            CustomButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              text: 'Close',
              color: const Color(0xff3E8989),
            ),
          ],
        ),
      ),
    );
  }
}
