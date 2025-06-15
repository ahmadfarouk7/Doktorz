import 'package:flutter/material.dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Pages/notifications.dart';
import 'package:gradproject/Pages/patient_profile.dart';
import 'package:gradproject/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            const Text(
              'Welcome , ',
              style: TextStyle(
                color: Color(0xff3E8989),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(kName,
                style: const TextStyle(
                  color: Color(0xff3E8989),
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Color(0xff3E8989),
            )),
        const SizedBox(
          width: 3,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => kRole == 'user'
                    ? const PatientProfile()
                    : DoctorProfile(id: kId!),
              ),
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(image),
          ),
        ),
      ],
    );
  }
}
