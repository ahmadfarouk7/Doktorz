import 'package:flutter/material.dart';
import 'package:gradproject/Pages/doctor_home.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/drawer.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/services/get_doctor_service.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xff3d8888),
        child: FutureBuilder<GetDoctorModel>(
            future: GetDoctorService().getDoctor(id: kId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DrawerWidgets(
                  image: snapshot.data!.photo,
                  name: snapshot.data!.fullName,
                  //email: snapshot.data!.
                );
              } else {
                return const Center(
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator()),
                );
              }
            }),
      ),
      bottomNavigationBar: const BottomNavBar(
        index: 0,
      ),
      body: const DoctorHome(),
    );
  }
}
