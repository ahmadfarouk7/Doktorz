import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/patient_preception.dart';
import 'package:gradproject/Pages/patient_today_appointement.dart';
import 'package:gradproject/Pages/waiting_list.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/pref.dart';

class AllPatientAppointements extends StatelessWidget {
  const AllPatientAppointements({
    super.key,
    required this.upComing,
    required this.past,
  });
  final List upComing;
  final List past;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(Prefs.getString('pat_image')!),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(child: Text(kName)),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'UpComing Appointement',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              upComing.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: upComing.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const WaitingList(),
                            ),
                          );
                        },
                        child: PatientAppio(
                          patientAppointemetDetails: upComing[index],
                        ),
                      ),
                    )
                  : const Text('You not have upcoming Appointements'),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Past Appointement',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              past.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: past.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PatientPreception(
                                id: past[index].id,
                                doctorImage: '',
                              ),
                            ),
                          );
                        },
                        child: PatientAppio(
                          patientAppointemetDetails: past[index],
                        ),
                      ),
                    )
                  : const Text('You not have past Appointements'),
            ],
          ),
        ),
      ),
    );
  }
}
