import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gradproject/Pages/chatbot.dart';
import 'package:gradproject/Pages/doctor_appointements.dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Pages/doctor_view.dart';
import 'package:gradproject/Pages/patient_today_appointement.dart';
import 'package:gradproject/Pages/patient_home.dart';
import 'package:gradproject/Pages/patient_profile.dart';
import 'package:gradproject/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.index;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  kRole == 'user' ? const HomePatient() : const DoctorView(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => kRole == 'user'
                  ? const PatientTodayAppointements()
                  : const DoctorAppointements(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const ChatBotPage(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => kRole == 'user'
                  ? const PatientProfile()
                  : DoctorProfile(
                      id: kId!,
                    ),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
          break;
        default:
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        selectedIndex: selectedIndex,
        onTabChange: onItemTapped,
        tabBackgroundColor: Colors.grey.shade200,
        padding: const EdgeInsets.all(18),
        activeColor: const Color.fromARGB(255, 88, 174, 174),
        color: const Color(0xff566369),
        gap: 5,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.calendar_today,
            text: 'Appointment',
          ),
          GButton(
            icon: Icons.forum,
            text: 'Chat bot',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
