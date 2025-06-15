import 'package:flutter/material.dart';

Widget buildButton(
     {required String text,required String imagePath, void Function()? onPressed}) {
  return SizedBox(
    width: 320,
    child: Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Circular border
            side: const BorderSide(
                color: Color(0xff3E8989), width: 1), // Green border
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 40,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ), // Text color
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
