// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:gradproject/Pages/doctor_preception.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/doctor_appoi_details.dart';
import 'package:gradproject/services/get_upcomimg_doctor_appoi.dart';
import 'package:intl/intl.dart';

class DoctorUpcomingAppointements extends StatefulWidget {
  const DoctorUpcomingAppointements({super.key});

  @override
  State<DoctorUpcomingAppointements> createState() =>
      _DoctorUpcomingAppointements();
}

List choosed = [true, false];

class _DoctorUpcomingAppointements extends State<DoctorUpcomingAppointements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
            future:
                GetUpComingDoctorAppointement().getDoctorAppointement(id: kId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List appointe = snapshot.data!;
                List approved = [];
                List upComing = [];
                List pastAppoin = [];
                for (int i = 0; i < appointe.length; i++) {
                  if (DateFormat('EEEE, MMMM d, y')
                      .parse(appointe[i].date.trim())
                      .isAfter(DateTime.now())) {
                    upComing.add(appointe[i]);
                    //print(upComing[i].date);
                  } else {
                    pastAppoin.add(appointe[i]);
                  }
                }
                return Column(
                  children: [
                    const CustomAppBar(
                      title: 'Appointments',
                      color: Colors.black,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          TwoOptionsStack(
                            text: 'Upcoming',
                            choosed: choosed[0],
                            onTap: () {
                              choosed[0] = true;
                              choosed[1] = false;

                              setState(() {});
                            },
                          ),
                          Positioned(
                            left: 117,
                            child: TwoOptionsStack(
                              text: 'Past',
                              choosed: choosed[1],
                              onTap: () {
                                choosed[0] = false;
                                choosed[1] = true;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (choosed[0])
                      if (upComing.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: upComing.length,
                              itemBuilder: (context, index) => UpcomingAppoi(
                                  onTap: () {
                                    approved.add(upComing[index]);
                                    upComing.remove(upComing[index]);
                                    for (var i in approved) {
                                      print(i.userName);
                                    }
                                    setState(() {});
                                  },
                                  doctorAppointemetDetails: upComing[index]),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                'Approved',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: approved.length,
                              itemBuilder: (context, index) => UpcomingAppoi(
                                  acc: true,
                                  doctorAppointemetDetails: approved[index]),
                            ),
                          ],
                        )
                      else
                        const Center(child: Text('You have not Appointement'))
                    else
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: pastAppoin.length,
                          itemBuilder: (context, index) => UpcomingAppoi(
                                doctorAppointemetDetails: pastAppoin[index],
                                canc: true,
                              )),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kColor,
                  ),
                );
              }
            }),
      ),
    );
  }
}

class UpcomingAppoi extends StatefulWidget {
  const UpcomingAppoi({
    super.key,
    this.acc = false,
    this.canc = false,
    required this.doctorAppointemetDetails,
    this.onTap,
  });
  final bool acc, canc;
  final void Function()? onTap;

  final DoctorAppointemetDetails doctorAppointemetDetails;

  @override
  State<UpcomingAppoi> createState() => _UpcomingAppoiState();
}

class _UpcomingAppoiState extends State<UpcomingAppoi> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DoctorPreception(
              userID: widget.doctorAppointemetDetails.id,
              image: widget.doctorAppointemetDetails.photo,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        child: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.75),
                )
              ],
            ),
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xff036363),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Appointement Request',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170,
                              child: ListTile(
                                minLeadingWidth: 0,
                                title:
                                    Text(widget.doctorAppointemetDetails.date,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        )),
                                leading: const Icon(
                                  Icons.assignment_turned_in,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: ListTile(
                                minLeadingWidth: 0,
                                title:
                                    Text(widget.doctorAppointemetDetails.time,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        )),
                                leading: const Icon(
                                  Icons.alarm,
                                  size: 12,
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
                    top: 80,
                    right: 3,
                    child: Container(
                      width: 360,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  widget.doctorAppointemetDetails.photo),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.doctorAppointemetDetails.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                widget.canc || widget.acc
                                    ? const SizedBox(
                                        width: 1,
                                      )
                                    : Row(
                                        children: [
                                          CustomButton(
                                            onTap: widget.onTap,
                                            text: 'Accept',
                                            width: 100,
                                            radius: 10,
                                            color: const Color(0xff036363),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          CustomButton(
                                            onTap: () {},
                                            text: 'cancel',
                                            textcolor: Colors.black,
                                            width: 100,
                                            radius: 10,
                                            color: const Color(0xffE6F2F2),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TwoOptionsStack extends StatelessWidget {
  const TwoOptionsStack(
      {super.key,
      required this.text,
      this.choosed = false,
      required this.onTap});
  final String text;
  final bool choosed;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 35,
        decoration: BoxDecoration(
          color: choosed ? const Color(0xff036363) : const Color(0xffEFEFEF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: choosed
              ? const TextStyle(
                  color: Colors.white,
                )
              : const TextStyle(
                  color: Colors.grey,
                ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
