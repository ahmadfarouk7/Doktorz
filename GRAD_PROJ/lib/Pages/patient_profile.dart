// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/Pages/update_doctor_profile.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_user_model.dart';
import 'package:gradproject/services/get_user_service.dart';
import 'package:gradproject/services/update_user_profile.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late Cloudinary cloudinary;
  @override
  void initState() {
    super.initState();
    cloudinary = Cloudinary.signedConfig(
      apiKey: '939799869145548',
      apiSecret: 'eFzHNda-ovMHLPhXCkG0lrKup_M',
      cloudName: 'dah8fxqsr',
    );
  }

  String imageUrl = '';
  String name = '';
  String phoneNumber = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    XFile? image;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 3,
      ),
      body: FutureBuilder<GetUserModel>(
          future: GetUserService().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(
                            flex: 4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      width: 100,
                                      onTap: () async {
                                        final ImagePicker picker =
                                            ImagePicker();
                                        image = await picker.pickImage(
                                            source: ImageSource.camera);
                                        if (image != null) {
                                          final response =
                                              await cloudinary.upload(
                                            file: image!.path,
                                            resourceType:
                                                CloudinaryResourceType.image,
                                          );

                                          setState(() {
                                            imageUrl = response.secureUrl!;
                                          });
                                        }
                                        print(imageUrl);
                                      },
                                      text: 'Take Photo',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomButton(
                                      width: 100,
                                      onTap: () async {
                                        final ImagePicker picker =
                                            ImagePicker();
                                        image = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        if (image != null) {
                                          final response =
                                              await cloudinary.upload(
                                            file: image!.path,
                                            resourceType:
                                                CloudinaryResourceType.image,
                                          );

                                          setState(() {
                                            imageUrl = response.secureUrl!;
                                          });
                                        }
                                        print(imageUrl);
                                      },
                                      text: 'Upload Photo',
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 53,
                          backgroundColor: const Color(0xff3E8989),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(snapshot.data!.photo),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        label: 'Name',
                        //  value: snapshot.data!.fullName,
                        onChanged: (valu) {
                          name = valu;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        label: 'Phone Number',
                        //  value: snapshot.data!.phoneNumber,
                        onChanged: (valu) {
                          phoneNumber = valu;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DoctorProfileDetails(
                        label: 'Email Address',
                        // value: snapshot.data!.email,
                        onChanged: (valu) {
                          email = valu;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onTap: () {
                          try {
                            UpdateUserProfileServices().updateUserProfile(
                              photo: imageUrl == ''
                                  ? snapshot.data!.photo
                                  : imageUrl,
                              fullName:
                                  name == '' ? snapshot.data!.fullName : name,
                              phoneNumber: phoneNumber == ''
                                  ? snapshot.data!.phoneNumber
                                  : phoneNumber,
                              email: email == '' ? snapshot.data!.email : email,
                            );
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Updated Successfully'),
                                backgroundColor: Colors.green,
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
                        text: 'Update Profile',
                        radius: 10,
                        color: const Color(0xff3DA7A7),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kColor,
                ),
              );
            }
          }),
    );
  }
}
