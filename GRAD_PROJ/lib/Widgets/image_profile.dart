import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.radius = 20,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage('assets/images/onboarding_img2.png'),
    );
  }
}
