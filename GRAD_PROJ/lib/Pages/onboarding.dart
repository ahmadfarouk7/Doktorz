import 'package:flutter/material.dart';
import 'package:gradproject/Pages/signup.dart';
import 'package:gradproject/Widgets/onboarding_comp.dart';
import 'package:gradproject/models/onboarding_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnboardingModel> pages = [
    OnboardingModel(
      img: "assets/images/onboarding_img1.jpg",
      title: "Professional Doctors",
      subTitle:
          "you will be able to choose among the most skilled doctors in differentspecialties",
    ),
    OnboardingModel(
      img: "assets/images/onboarding_img2.png",
      title: "All About Patient Health",
      subTitle:
          "you will find a lot of tips and advice to tell you how to prevent health and avoid disease",
    ),
    OnboardingModel(
      img: "assets/images/onboarding_img3.jpg",
      title: "Consultations & appointment",
      subTitle:
          "you can now make your consultations with your doctor anywhere and anytime ",
    ),
    OnboardingModel(
      img: "assets/images/onboarding_img5.png",
      title: "Chatbot Support",
      subTitle:
          "Get access to  via chatbot for a fantastic telepathy Services.",
      cover: false,
    ),
  ];
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return OnBoardingComponents(
                onboardingModel: pages[index],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 50,
            right: 0,
            child: Container(
              height: 60,
              color: const Color(0xff3d8888),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pages.length, (index) {
                        return currentIndex == index
                            ? pageIndexIndicator(true)
                            : pageIndexIndicator(false);
                      }),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentIndex != pages.length - 1) {
                        pageController.animateToPage(
                          pages.length - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.linear,
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      currentIndex != pages.length - 1 ? "SKIP" : "START",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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

Widget pageIndexIndicator(bool isCurrentPage) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    height: 12,
    width: 12,
    decoration: BoxDecoration(
      color: isCurrentPage ? Colors.white : Colors.grey,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
