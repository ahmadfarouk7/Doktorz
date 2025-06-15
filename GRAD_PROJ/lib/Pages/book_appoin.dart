// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Pages/payment._options.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/services/book_appointement_services.dart';
import 'package:gradproject/services/get_avilable_time.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointement extends StatefulWidget {
  const BookAppointement({super.key, required this.id, this.ticketPrice, this.specialization, this.doctorName});
  final String id;
  final dynamic ticketPrice;
  final dynamic specialization;
  final dynamic doctorName;
  @override
  State<BookAppointement> createState() => _BookAppointementState();
}

class _BookAppointementState extends State<BookAppointement> {
  var today = DateTime.now();
  TextEditingController controller = TextEditingController();
  dynamic time;
  String userName = '';
  String phoneNumber = '';
  String age = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: 'Book Appointement',
                color: Colors.black,
                textColor: Colors.black,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  lastDay: DateTime.utc(2026, 3, 14),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      today = selectedDay;
                    });
                    print(DateFormat('yyyy-MM-dd').format(today));
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
                height: 60,
              ),
              const Text(
                'Avilable Time',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder<List<dynamic>>(
                  future: GetAvilableTime().getAviliableTime(
                    id: widget.id,
                    date: DateFormat.yMMMMEEEEd().format(today),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List avilableTimes = snapshot.data!;
                      if (avilableTimes.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: avilableTimes.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            childAspectRatio: 4,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                time = avilableTimes[index];
                                print(time);
                              },
                              child: TimeSlots(
                                time: avilableTimes[index],
                              ),
                            );
                          },
                        );
                      } else {
                        return const ShowDialogAppoi();
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff44A0A0),
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomListTile(
                      icon: Icons.people,
                      title: 'Patient Details',
                      color: const Color(0xff3DA7A7),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  //const Spacer(),2
                  const SizedBox(
                    width: 60,
                  ),
                  Text(
                    'Ticket Price  ${widget.ticketPrice}EGP',
                    style: TextStyle(
                      color: const Color(0xff3DA7A7),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              PatientDetails(
                label: 'Full Name',
                onChanged: (value) {
                  userName = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PatientDetails(
                label: 'Age',
                onChanged: (value) {
                  age = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PatientDetails(
                label: 'Phone Number',
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomButton(
                  onTap: () async {
                    Map<String, dynamic> data = await BookAppointementService()
                        .bookApoointemt(
                            doctorId: widget.id,
                            userName: userName,
                            time: time,
                            phoneNumber: phoneNumber,
                            date: DateFormat.yMMMMEEEEd().format(today),
                            age: int.parse(age));
                    if (data['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(data['message']),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            amount: widget.ticketPrice,
                            id: data['appointment']['_id'],
                            doctorName: widget.doctorName,
                            specialization: widget.specialization,
                            data: data['appointment']['date'],
                            time: data['appointment']['time'],
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(data['message']),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  text: 'Request Appointement',
                  radius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSlots extends StatelessWidget {
  const TimeSlots({
    super.key,
    required this.time,
  });
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.5,
              color: Colors.black26,
              offset: Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class PatientDetails extends StatelessWidget {
  const PatientDetails({
    super.key,
    required this.label,
    this.onChanged,
  });
  final String label;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff455A64),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class ShowDialogAppoi extends StatelessWidget {
  const ShowDialogAppoi({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_appoin-removebg-preview.png',
            width: 100,
          ),
          const SizedBox(height: 16),
          const Text(
              'There is no appointement in that time, please choose another date'),
        ],
      ),
    );
  }
}
