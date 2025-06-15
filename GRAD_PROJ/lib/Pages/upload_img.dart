import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    XFile? image;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Verify Account',
            ),
            const Text(
              'take a photo of your Syndicate',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(
              'assets/images/Image upload-amico1.svg',
            ),
            CustomButton(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.camera);
                Navigator.of(context).pop(image);
              },
              text: 'Take Photo',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context).pop(image);
              },
              text: 'Upload Photo',
            ),
          ],
        ),
      ),
    );
  }
}
