import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Change_pass.dart';
import 'package:gradproject/Pages/Login.dart';
import 'package:gradproject/Pages/patient_home.dart';
import 'package:gradproject/Pages/patient_profile.dart';
import 'package:gradproject/Widgets/SettingsCompo.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/SettingsModel.dart';
import 'package:gradproject/pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  XFile? image;
  bool _isOpen = false;

  final ImagePicker picker = ImagePicker();
  final List<SettingsModel> categories = [
    SettingsModel(
      icon: Icons.person,
      title: 'Profile Information',
      icon2: Icons.arrow_forward_ios,
      onTap: (context) {
        print("Tapped on Profile Information"); // Debugging statement
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PatientProfile()),
        );
      },
    ),
    SettingsModel(
      icon: Icons.lock_outline,
      title: 'Change Password',
      icon2: Icons.arrow_forward_ios,
    ),
    SettingsModel(
      icon: Icons.payment,
      title: 'Payment Method',
      icon2: Icons.arrow_forward_ios,
    ),
    SettingsModel(
      icon: Icons.location_pin,
      title: 'Locations',
      icon2: Icons.arrow_forward_ios,
    ),
    SettingsModel(
      icon: Icons.share,
      title: 'Refer to friends',
      icon2: Icons.arrow_forward_ios,
      onTap: (context) {
        const String text = 'Download this awesome app , Helped me a lot';
        Share.share(text);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text(
            'Settings',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePatient()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(Prefs.getString('pat_image')!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15),
              child: Text(
                kName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientProfile()),
                  );
                },
                child: SettingsCompo(settingsModel: categories[0])),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()),
                  );
                },
                child: SettingsCompo(settingsModel: categories[1])),
            SettingsCompo(settingsModel: categories[2]),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePatient()),
                  );
                },
                child: SettingsCompo(settingsModel: categories[3])),
            if (categories.length > 4) // Check for nullability
              GestureDetector(
                onTap: () {
                  if (categories[4].onTap != null) {
                    categories[4].onTap!(
                        context); // Invoke onTap with context if not null
                  }
                },
                child: SettingsCompo(settingsModel: categories[4]),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    weight: 25,
                    size: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 25),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isOpen = !_isOpen; // Toggle the color
                      });
                    },
                    child: Container(
                      width: 55,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the radius as needed
                        color: _isOpen ? Colors.grey : Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: _isOpen
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 208, 211, 211),
                            content: const Text('Are you sure to Log Out ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                    (Route<dynamic> route) =>
                                        false, // Clear all routes and go to login
                                  );
                                },
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffD03838),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.logout_outlined,
                    color: Color(0xffD03838),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
