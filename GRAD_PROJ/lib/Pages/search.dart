// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:gradproject/Pages/all_doctors2%20(3).dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Widgets/home_app_bar.dart';
import 'package:gradproject/Widgets/serach_field.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/pref.dart';
import 'package:gradproject/services/search_doctors.dart';

class SearchDoctors extends StatelessWidget {
  const SearchDoctors({
    super.key,
    required this.searchType,
    required this.value,
  });
  final String searchType;
  final String value;
  @override
  Widget build(BuildContext context) {
    String id;
    String name;
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
            const SearchField(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: FutureBuilder<List<GetDoctorModel>>(
                  future: SerarchDoctorsService()
                      .searchDoctors(searchType: searchType, value: value),
                  builder: (context, snapshot) {
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
