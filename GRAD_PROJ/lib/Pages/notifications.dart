import 'package:flutter/material.dart';
import 'package:gradproject/Widgets/custom_app_bar.dart';
import 'package:gradproject/styles.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: 'Notifications',
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Today 7-7 JUL',
                style: Styles.fontSize15,
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) => const NotifiCompo(
                  img: 'assets/images/check.jpg',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Yesterday 23-DEC',
                style: Styles.fontSize15,
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => const NotifiCompo(
                  img: 'assets/images/check.jpg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotifiCompo extends StatelessWidget {
  const NotifiCompo({
    super.key,
    required this.img,
  });

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(30, 62, 137, 137),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(img),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remeber:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Your reminder appointment will start after 16 minutes, stay on the app.',
                  style: TextStyle(
                    color: Color.fromARGB(153, 0, 0, 0),
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '10:00 AM',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
