import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.width = 270,
      this.color = const Color(0xff3d8888),
      this.textcolor = Colors.white,
      this.radius = 40,
      this.isloading = false});
  final void Function()? onTap;
  final String text;
  final double width;
  final Color color;
  final Color textcolor;
  final double radius;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.w,
            ),
            child: isloading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: textcolor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
