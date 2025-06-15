// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/Pages/upload_img.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/Widgets/verify_options.dart';
import 'package:gradproject/pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class VerifyMehods extends StatefulWidget {
  const VerifyMehods({super.key, required this.doctorData});
  final Map<String, dynamic> doctorData;

  @override
  State<VerifyMehods> createState() => _VerifyMehodsState();
}

class _VerifyMehodsState extends State<VerifyMehods> {
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
  String videoUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Verify Account',
          ),
          const Text(
            'Choose your document type',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 50,
          ),
          VerifyOptions(
            contact: 'Video',
            subtext: '30s talk about your self',
            icon: Icons.videocam,
            onTap: () async {
              try {
                final imagePicker = ImagePicker();
                final pickedVideo =
                    await imagePicker.pickVideo(source: ImageSource.gallery);

                if (pickedVideo != null) {
                  final response = await cloudinary.upload(
                    file: pickedVideo.path,
                    resourceType: CloudinaryResourceType.video,
                  );

                  setState(() {
                    videoUrl = response.secureUrl!;
                  });
                }
                print(videoUrl);
              } catch (e) {
                print('Video upload error: $e');
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          VerifyOptions(
            contact: 'Syndicate Card',
            icon: Icons.content_paste,
            onTap: () async {
              final image = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UploadImage(),
                ),
              );
              if (image != null) {
                final response = await cloudinary.upload(
                  file: image.path,
                  resourceType: CloudinaryResourceType.image,
                );

                setState(() {
                  imageUrl = response.secureUrl!;
                });
              }
              print(imageUrl);
            },
          ),
          const SizedBox(
            height: 60,
          ),
          CustomButton(
            onTap: () {
              signUp();
            },
            text: 'Verify',
          )
        ],
      ),
    );
  }

  void signUp() {
    // Extract user data

    // Send sign-up request to the API
    http
        .post(
      Uri.parse('https://doctorz.onrender.com/api/v1/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'fullName': widget.doctorData['fullName'],
        'email': widget.doctorData['email'],
        'gender': widget.doctorData['gender'],
        'age': widget.doctorData['age'],
        'phoneNumber': widget.doctorData['phoneNumber'],
        'password': widget.doctorData['password'],
        'passwordConfirm': widget.doctorData['confirmPassword'],
        'userType': 'doctor',
        'video': videoUrl,
        'card': imageUrl,
      }),
    )
        .then((response) {
      var data = jsonDecode(response.body);
      print(data);
      if (data['status'] == 'success') {
        Prefs.setString('ID', data['data']['user']['_id']);
        Prefs.setString('token', data['token']);
        print('idd ${Prefs.getString('ID')}');
        print('token ${Prefs.getString('token')}');
        // If sign-up is successful, navigate to appropriate page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Success'),
          ),
        );
      } else {
        // If sign-up fails, display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
          ),
        );
      }
    }).catchError((error) {
      // If an error occurs during sign-up, display error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while signing up.'),
        ),
      );
    });
  }
}
