
import 'package:flutter/material.dart';
import 'package:gradproject/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: TextFormField(
        controller: controller,
        //obscureText: true,
        // validator: (value) {
        //   if (value?.isEmpty ?? true) {
        //     return 'The field is required';
        //   } else {
        //     return null;
        //   }
        // },
        cursorColor: kColor,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.lock),
          suffixIconColor: kColor,
          labelText: text,
          labelStyle: const TextStyle(color: kColor),
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(),
        ),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kColor));
  }
}
