import 'package:flutter/material.dart';
import 'package:gradproject/Pages/doctor_view.dart';
import 'package:gradproject/Pages/update_doctor_profile.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/services/get_doctor_service.dart';
import 'package:gradproject/services/update_doctor_service.dart';

class ContinueUpdateDoctor extends StatelessWidget {
  const ContinueUpdateDoctor({
    super.key,
    this.doctorData,
  });
  final dynamic doctorData;
  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';
    String achievement = '';
    String city ='';
    String area = '';
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 3,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder<GetDoctorModel>(
            future: GetDoctorService().getDoctor(id: kId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(snapshot.data!.photo),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(kName),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      DoctorProfileDetails(
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        label: 'Phone Number of clinc',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        onChanged: (value) {
                          achievement = value;
                        },
                        label: 'Achivement',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const DoctorProfileDetails(
                        label: 'Number of vodafone cash',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        onChanged: (value) {
                          city = value;
                        },
                        label: 'choose City',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        onChanged: (value) {
                          area = value;
                        },
                        label: 'choose Area',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onTap: () {
                          try {
                            UpdateDoctorProfileServices().updateDoctorProfile(
                              photo: doctorData['image'] == ''
                                  ? snapshot.data!.photo
                                  : doctorData['image'],
                              about: doctorData['about'] == ''
                                  ? snapshot.data!.about
                                  : doctorData['about'],
                              hospital: doctorData['hospital'] == ''
                                  ? snapshot.data!.about
                                  : doctorData['hospital'],
                              city: city == '' ? snapshot.data!.city : city,
                              area: area == '' ? snapshot.data!.area : area,
                              specialization:
                                  doctorData['specialization'] == null
                                      ? snapshot.data!.specialization
                                      : doctorData['specialization'],
                              achievements: achievement == ''
                                  ? snapshot.data!.achievements
                                  : achievement,
                              ticketPrice: doctorData['ticketPrice'] == ''
                                  ? snapshot.data!.ticketPrice
                                  : doctorData['ticketPrice'],
                              phoneNumber: phoneNumber == ''
                                  ? snapshot.data!.phoneNumber
                                  : phoneNumber,
                                  yearsExperience:doctorData['yearsExperience'] == ''?snapshot.data!.yearsExperience:doctorData['yearsExperience']
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Updated Successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DoctorView(),
                              ),
                            );
                          } on Exception catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        text: 'Update Profle',
                        radius: 10,
                        color: const Color(0xff3DA7A7),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: kColor,),
                );
              }
            }),
      ),
    );
  }
}
