// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, await_only_futures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/book_appoin.dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Pages/search.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/Widgets/home_app_bar.dart';
import 'package:gradproject/Widgets/serach_field.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/pref.dart';
import 'package:gradproject/services/get_all_doctors_service.dart';
import 'package:http/http.dart' as http;

class AllDoctors2 extends StatelessWidget {
  const AllDoctors2({super.key});
  @override
  Widget build(BuildContext context) {
    String id;
    String name;
    String searchName;
    String selected;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          children: [
            HomeAppBar(
              image: Prefs.getString('pat_image')!,
            ),
            const SizedBox(
              height: 8,
            ),
            SearchField(
              onSubmitted: (value) {
                searchName = value;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchDoctors(
                      searchType: 'fullName',
                      value: 'Dr $searchName',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: FutureBuilder<List<GetDoctorModel>>(
                  future: GetAllDoctorsService().getAllDoctors(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      List<GetDoctorModel> doctors = snapshot.data!;
                      return ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            id = doctors[index].id;
                            name = doctors[index].fullName;
                            print(id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorProfile(
                                  id: id,
                                ),
                              ),
                            );
                          },
                          child: DoctorCard(
                            doctorsModel: doctors[index],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xff3d8888)),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    Key? key,
    required this.doctorsModel,
  }) : super(key: key);

  final GetDoctorModel doctorsModel;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  // Future<String?> getPatientId() async {
  Future<void> saveDoctor(String patientId, String token) async {
    if (patientId.isEmpty || token.isEmpty) {
      print('Patient ID or token is empty.');
      return;
    }

    String url =
        'https://doctorz.onrender.com/api/v1/users/bookmarkedDoctors/${widget.doctorsModel.id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    String body = jsonEncode({kId: patientId});
    print(body);

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        // Doctor saved successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Doctor saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
        print('Doctor saved successfully');
      } else {
        // Failed to save doctor
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save doctor'),
            backgroundColor: Colors.red,
          ),
        );
        print('Failed to save doctor');
      }
    } catch (e) {
      // Exception occurred
      print('Error: $e');
    }
  }

  Future<void> removeDoctor() async {
    String? token = await kToken;

    if (token == null) {
      print('Token not found.');
      return;
    }

    String url =
        'https://doctorz.onrender.com/api/v1/users/bookmarkedDoctors/${widget.doctorsModel.id}';
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // Doctor removed successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Doctor removed successfully'),
            backgroundColor: Colors.green,
          ),
        );
        print('Doctor removed successfully');
      } else {
        // Failed to remove doctor
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to remove doctor'),
            backgroundColor: Colors.red,
          ),
        );
        print('Failed to remove doctor');
      }
    } catch (e) {
      // Exception occurred
      print('Error: $e');
    }
  }

  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      padding: EdgeInsets.all(16.h),
      margin: EdgeInsets.only(
        bottom: 16.h,
        left: 10.w,
        right: 10.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.5,
            color: Colors.black26,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.doctorsModel.photo),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomListTile(
                  icon: Icons.star,
                  title: '${widget.doctorsModel.ratingAverage}',
                  color: Colors.amber,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                  widget.doctorsModel.fullName,
                  style: TextStyle(
                    color: const Color(0xff3E8989),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text('${widget.doctorsModel.specialization } '),
                Text(
                    '${widget.doctorsModel.startWorkingTime} - ${widget.doctorsModel.endWorkingTime}'),
                SizedBox(
                  height: 12.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointement(
                          id: widget.doctorsModel.id,
                          ticketPrice: widget.doctorsModel.ticketPrice,
                          doctorName: widget.doctorsModel.fullName,
                          specialization: widget.doctorsModel.specialization,
                        ),
                      ),
                    );
                  },
                  text: 'Appointement',
                  radius: 10,
                  width: 180.w,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30.w,
            child: IconButton(
              onPressed: () {
                if (!isSaved) {
                  isSaved = true;
                  setState(() {});
                  print(kId);
                  print(kToken);
                  saveDoctor(kId!, kToken!);
                } else {
                  isSaved = false;
                  setState(() {});
                  removeDoctor();
                }
              },
              icon: Icon(
                Icons.bookmark,
                size: 32.sp,
                color:
                    isSaved ? const Color(0xff3E8989) : const Color(0xffA19C9C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
