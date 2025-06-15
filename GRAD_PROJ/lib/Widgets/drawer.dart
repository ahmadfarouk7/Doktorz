import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Saved_doctor%20(2).dart';
import 'package:gradproject/Pages/settings.dart';
import 'package:gradproject/Pages/notifications.dart';
import 'package:gradproject/Widgets/serach_field.dart';

class DrawerWidgets extends StatelessWidget {
  const DrawerWidgets({
    super.key,
    this.name = 'guset',
    this.email = 'user@gmail.com',
    required this.image,
  });
  final String name;
  final String email;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(name,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xff273840),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 40,
              child: SearchField(
                padding: 6,
                hint: 'Search..',
                radius: 10,
                fillcolor: Color.fromARGB(163, 217, 217, 217),
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const DrawerCompo(
              icon: Icons.campaign,
              text: 'Up coming  consulations',
            ),
            const DrawerCompo(
              icon: Icons.calendar_today,
              text: 'Appointement',
            ),
            const DrawerCompo(
              icon: Icons.forum,
              text: 'ChatBot',
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
              child: const DrawerCompo(
                icon: Icons.notifications,
                text: 'Notification',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SavedDoctors(),
                  ),
                );
              },
              child: const DrawerCompo(
                icon: Icons.bookmark,
                text: 'Saved',
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: const DrawerCompo(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ),
            const DrawerCompo(
              icon: Icons.flag,
              text: 'Report',
            ),
            const DrawerCompo(
              icon: Icons.info,
              text: 'Support',
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawerCompo extends StatelessWidget {
  const DrawerCompo({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
          )
        ],
      ),
    );
  }
}
