import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradproject/Pages/search.dart';
import 'package:gradproject/Widgets/home_app_bar.dart';
import 'package:gradproject/Widgets/serach_field.dart';
import 'package:gradproject/pref.dart';

class Filter extends StatelessWidget {
  const Filter({super.key, required this.listType, required this.type});
  final List<dynamic> listType;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          children: [
            HomeAppBar(image: Prefs.getString('pat_image')!),
            const SizedBox(
              height: 20,
            ),
            SearchField(
              hint: 'Search by $type',
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listType.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchDoctors(
                              searchType: type, value: listType[index]),
                        ),
                      );
                    },
                    child: Text(
                      listType[index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
