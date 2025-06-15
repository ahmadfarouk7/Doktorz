// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/models/visit_details.dart';
import 'package:gradproject/services/get_doctor_appoi.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorAppointements extends StatefulWidget {
  const DoctorAppointements({super.key});

  @override
  State<DoctorAppointements> createState() => _DoctorAppointementsState();
}

class _DoctorAppointementsState extends State<DoctorAppointements> {
  var today = DateTime.now();
  var selected = DateFormat.yMMMMEEEEd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 1,
      ),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Book Appointment',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(110, 239, 238, 238),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0.5,
                      color: Colors.black26,
                      offset: Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TableCalendar(
                rowHeight: 35,
                focusedDay: today,
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    today = selectedDay;
                  });
                  selected = DateFormat.yMMMMEEEEd().format(today);
                  print(selected);
                },
                locale: "en_US",
                selectedDayPredicate: (day) => isSameDay(today, day),
                availableGestures: AvailableGestures.all,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xff44A0A0),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<dynamic>>(
                future: GetDoctorAppointement()
                    .getDoctorAppointement(date: selected),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List appointements = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              selected,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '(${appointements.length}  Patients)',
                              style: const TextStyle(
                                color: Color(0xff9C9A9A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: appointements.length,
                            itemBuilder: (context, index) => Visits(
                              visitsDetails: appointements[index],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff44A0A0),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class Visits extends StatelessWidget {
  const Visits({
    super.key,
    required this.visitsDetails,
  });
  final VisitsDetails visitsDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            visitsDetails.time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 80,
              left: 10,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff303E46),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    'assets/images/onboarding_img2.png',
                    width: 80,
                    height: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      visitsDetails.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Check up visit',
                      style: TextStyle(
                        color: Color(0xff9C9A9A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
