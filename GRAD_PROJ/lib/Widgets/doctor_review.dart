import 'package:flutter/material.dart';
import 'package:gradproject/constants.dart';

class DoctorReview extends StatelessWidget {
  const DoctorReview(
      {super.key, required this.icon, required this.num, required this.text});
  final IconData icon;
  final String num;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: MediaQuery.of(context).size.width / 3.7,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 243, 241, 241),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 65,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: kColor,
              size: 36,
            ),
          ),
          Text(
            num,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0xff808080)),
          ),
        ],
      ),
    );
  }
}
