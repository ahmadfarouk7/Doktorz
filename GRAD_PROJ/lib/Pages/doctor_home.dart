import 'package:flutter/material.dart';
import 'package:gradproject/Pages/doctor_upcomping_appointements.dart';
import 'package:gradproject/Widgets/doctor_review.dart';
import 'package:gradproject/Widgets/home_app_bar.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/models/visit_details.dart';
import 'package:gradproject/services/get_doctor_appoi.dart';
import 'package:gradproject/services/get_doctor_service.dart';
import 'package:intl/intl.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<GetDoctorModel>(
                  future: GetDoctorService().getDoctor(id: kId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomeAppBar(
                        image: snapshot.data!.photo,
                      );
                    } else {
                      return const Center(
                        child: SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              color: kColor,
                            )),
                      );
                    }
                  }),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    hintText: 'Search for Doctor',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 26,
                    ),
                    prefixIconColor: Colors.grey,
                    filled: true,
                    fillColor: Color.fromARGB(255, 243, 241, 241),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 243, 235, 235),
                      ),
                    ),
                  ),
                ),
              ),
              const Row(
                children: [
                  DoctorReview(
                    icon: Icons.people,
                    num: '90',
                    text: 'Visits last Week',
                  ),
                  DoctorReview(
                    icon: Icons.star,
                    num: '18',
                    text: 'Evaluations last Week',
                  ),
                  DoctorReview(
                    icon: Icons.assignment_turned_in,
                    num: '90',
                    text: 'prescription last Week',
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today Appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const DoctorUpcomingAppointements(),
                          ),
                        );
                      },
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kColor,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<dynamic>>(
                  future: GetDoctorAppointement().getDoctorAppointement(
                      date: DateFormat.yMMMMEEEEd().format(DateTime.now())),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List appoins = snapshot.data!;
                      if (appoins.isNotEmpty) {
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemBuilder: (context, index) => TodayAppointment(
                              visitsDetails: appoins[index],
                            ),
                            itemCount: appoins.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('You have not appointements Today'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kColor,
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kColor,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<dynamic>>(
                  future: GetDoctorAppointement().getDoctorAppointement(
                      date: DateFormat.yMMMMEEEEd()
                          .format(DateTime.now().add(const Duration(days: 1)))),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List appoins = snapshot.data!;
                      if (appoins.isNotEmpty) {
                        return SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemBuilder: (context, index) => NextAppoin(
                              visitsDetails: appoins[index],
                            ),
                            itemCount: appoins.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('You have not appointements Tomorrow'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kColor,
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class NextAppoin extends StatelessWidget {
  const NextAppoin({
    super.key,
    required this.visitsDetails,
  });
  final VisitsDetails visitsDetails;
  @override
  Widget build(BuildContext context) {
    dynamic tomorrow = DateFormat.yMMMMEEEEd()
        .format(DateTime.now().add(const Duration(days: 1)));
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(bottom: 10, left: 10),
      width: 370,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 241, 241),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kColor),
            child: const Icon(
              Icons.alarm_sharp,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tomorrow,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                visitsDetails.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TodayAppointment extends StatelessWidget {
  const TodayAppointment({
    super.key,
    required this.visitsDetails,
  });
  final VisitsDetails visitsDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
      ),
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 180,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(
                visitsDetails.time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Positioned(
            top: 60,
            child: Container(
              width: 300,
              height: 120,
              decoration: BoxDecoration(
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.75))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        visitsDetails.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff44A0A0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: const Text(
                          'Check Up Visit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage('assets/images/onboarding_img2.png'),
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
