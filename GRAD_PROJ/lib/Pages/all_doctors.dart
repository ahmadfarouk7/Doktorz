// // ignore_for_file: avoid_print, unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:gradproject/Pages/doctor_profile.dart';
// import 'package:gradproject/Widgets/custom_button.dart';
// import 'package:gradproject/Widgets/home_app_bar.dart';
// import 'package:gradproject/Widgets/serach_field.dart';
// import 'package:gradproject/constants.dart';
// import 'package:gradproject/models/get_all_doctors_model.dart';
// import 'package:gradproject/pref.dart';
// import 'package:gradproject/services/get_all_doctors_service.dart';

// class AllDoctors extends StatelessWidget {
//   const AllDoctors({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String id;
//     String name;
//     String phoneNumber;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//                         vertical: 35, horizontal: 20),
//         child: Column(
//           children: [
//             HomeAppBar(image: Prefs.getString('pat_image')!,),
//             const SizedBox(
//               height: 8,
//             ),
//             const SearchField(),
//             const SizedBox(
//               height: 8,
//             ),
//             Expanded(
//               child: FutureBuilder<List<GetAllDoctorsModel>>(
//                   future: GetAllDoctorsService().getAllDoctors(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       List<GetAllDoctorsModel> doctors = snapshot.data!;
//                       return ListView.builder(
//                         itemCount: doctors.length,
//                         itemBuilder: (context, index) => GestureDetector(
//                           onTap: () {
//                             id = doctors[index].id;
//                             name = doctors[index].fullName;
//                             print(id);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DoctorProfile(
//                                   id: id,
                                  
//                                 ),
//                               ),
//                             );
//                           },
//                           child: DoctorCard(
//                             doctorsModel: doctors[index],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DoctorCard extends StatelessWidget {
//   const DoctorCard({
//     super.key,
//     required this.doctorsModel,
//   });
//   final GetAllDoctorsModel doctorsModel;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 0.5,
//               color: Colors.black26,
//               offset: Offset(3, 3),
//             )
//           ]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               const CircleAvatar(
//                 radius: 30,
//                 backgroundImage:
//                     AssetImage('assets/images/onboarding_img2.png'),
//               ),
//               CustomListTile(
//                 icon: Icons.star,
//                 color: Colors.amber,
//                 title: '${doctorsModel.ratingAverage}',
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Text(
//                 doctorsModel.fullName,
//                 style: const TextStyle(
//                   color: kColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const Text('AlZhour Hospital, Ismailia'),
//               Text(
//                   '${doctorsModel.startWorkingTime} - ${doctorsModel.endWorkingTime}'),
//               const SizedBox(
//                 height: 12,
//               ),
//               CustomButton(
//                 onTap: () {},
//                 text: 'Appointement',
//                 radius: 10,
//                 width: 200,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
