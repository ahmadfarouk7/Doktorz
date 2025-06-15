import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/patient_appointements.dart';
import 'package:gradproject/Pages/waiting_list.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/image_profile.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_user_model.dart';
import 'package:gradproject/models/patient_appoi_model.dart';
import 'package:gradproject/services/get_patient_appointement.dart';
import 'package:gradproject/services/get_user_service.dart';
import 'package:intl/intl.dart';

class PatientTodayAppointements extends StatelessWidget {
  const PatientTodayAppointements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 40.h,
        ),
        child: FutureBuilder<GetUserModel>(
            future: GetUserService().getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.sort,
                            color: Color(0xff3E8989),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 53,
                        backgroundColor: const Color(0xff3E8989),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(snapshot.data!.photo),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        snapshot.data!.fullName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data!.age}yrs',
                            style: const TextStyle(
                              color: Color(0xff455A64),
                            ),
                          ),
                          SizedBox(
                            width: 20.h,
                          ),
                          Text(
                            snapshot.data!.gender,
                            style: const TextStyle(
                              color: Color(0xff455A64),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      FutureBuilder<List<dynamic>>(
                          future: GetPatientAppointement()
                              .getPatientAppointement(id: kId!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List appointe = snapshot.data!;
                              List upComing = [];
                              List pastAppoin = [];
                              for (int i = 0; i < appointe.length; i++) {
                                if (DateFormat('EEEE, MMMM d, y')
                                    .parse(appointe[i].date)
                                    .isAfter(DateTime.now())) {
                                  upComing.add(appointe[i]);
                                  //print(upComing[i].date);
                                } else {
                                  pastAppoin.add(appointe[i]);
                                }
                              }
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'My Appointements',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllPatientAppointements(
                                                upComing: upComing,
                                                past: pastAppoin,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'View all',
                                          style: TextStyle(
                                              color: Color(0xff3E8989)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  upComing.isNotEmpty
                                      ? PatientAppio(
                                          patientAppointemetDetails:
                                              upComing[0],
                                        )
                                      : const Text(
                                          'You not have upcoming Appointements'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 170, top: 30),
                                    child: Text(
                                      'Timer of Appointement',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  upComing.isNotEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(15.h),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffECFFF2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            upComing[0].photo),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          upComing[0]
                                                              .doctorName,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Text(
                                                          'Your Reminder appointment will be start after three patient',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color
                                                                .fromARGB(
                                                                153, 0, 0, 0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const WaitingList(),
                                                      ),
                                                    );
                                                  },
                                                  child:
                                                      const WaitingCounter()),
                                            ],
                                          ),
                                        )
                                      : const Text(
                                          'You not have upComing Appointements')
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class PatientAppio extends StatelessWidget {
  const PatientAppio({
    super.key,
    required this.patientAppointemetDetails,
  });
  final PatientAppointemetDetails patientAppointemetDetails;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20.w,
              top: 5.h,
            ),
            height: 92.h,
            decoration: BoxDecoration(
              color: const Color(0xff3D9D9D),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointement Request',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(patientAppointemetDetails.date,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                            )),
                        leading: Icon(
                          Icons.assignment_turned_in,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.w,
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(patientAppointemetDetails.time,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                            )),
                        leading: Icon(
                          Icons.alarm,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 78.h,
            right: 3.w,
            child: Container(
              width: 410.w,
              height: 100.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.75,
                    offset: Offset(3, 3),
                  )
                ],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(patientAppointemetDetails.photo),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          patientAppointemetDetails.doctorName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          patientAppointemetDetails.specialization,
                          style: TextStyle(
                            color: const Color(0xffBEBEBE),
                            fontWeight: FontWeight.w600,
                            fontSize: 8.sp,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingCounter extends StatelessWidget {
  const WaitingCounter({
    super.key,
    this.color = Colors.black,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    '21',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'HOURS',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffA19C9C),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                ':',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffA19C9C),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                children: [
                  Text(
                    '24',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'MINUTES',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffA19C9C),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 50.w,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 25.sp,
                  color: Colors.white,
                ),
                Text(
                  '3',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
