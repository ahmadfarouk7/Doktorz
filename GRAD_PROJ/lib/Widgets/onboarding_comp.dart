import 'package:flutter/material.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/onboarding_model.dart';

class OnBoardingComponents extends StatelessWidget {
  const OnBoardingComponents({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: onboardingModel.cover ? 0 : 350,
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardingModel.img),
                  fit: onboardingModel.cover ? BoxFit.cover : BoxFit.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 400),
            width: 428,
            height: 363,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
              ),
              color: kColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, right: 20, left: 20),
                  child: Text(
                    onboardingModel.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    onboardingModel.subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
