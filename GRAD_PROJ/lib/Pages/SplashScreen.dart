import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradproject/Pages/FOnBoarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const FonBoarding()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 55, 125, 125),
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -100,
            child: ClipOval(
              child: Container(
                width: 300,
                height: 300,
                color: const Color.fromARGB(
                    255, 70, 135, 135), // Change color as needed
              ),
            ),
          ),
          // Bottom right wavy circle
          Positioned(
            bottom: -80,
            right: -100,
            child: ClipOval(
              child: Container(
                width: 250,
                height: 250,
                color: const Color.fromARGB(255, 70, 135, 135),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 275.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logoblack.png',
                    height: 150,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
