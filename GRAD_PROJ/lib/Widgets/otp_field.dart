
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradproject/constants.dart';

class OTPField extends StatelessWidget {
  const OTPField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 7,
      child: TextFormField(
        controller: controller,
        cursorColor: kColor,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kColor,
              width: 5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kColor, width: 4),
          ),
        ),
      ),
    );
  }
}
