import 'package:flutter/material.dart';
import 'package:gradproject/models/SettingsModel.dart';

class SettingsCompo extends StatelessWidget {
  const SettingsCompo({Key? key, required this.settingsModel})
      : super(key: key);
  final SettingsModel settingsModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                settingsModel.icon,
                size: 30,
                color: Colors.grey,
              ),
              const SizedBox(width: 25),
              Text(
                settingsModel.title!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const Spacer(
                flex: 3,
              ),
              Icon(
                settingsModel.icon2,
                weight: 25,
                size: 20,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 10,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
