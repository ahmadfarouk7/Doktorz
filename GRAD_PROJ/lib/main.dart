import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/Login.dart';
import 'package:gradproject/Pages/SplashScreen.dart';
import 'package:gradproject/Pages/chatbot.dart';
import 'package:gradproject/pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 815),
      builder: (context, child) => SafeArea(
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Open Sans',
          ),
          debugShowCheckedModeBanner: false,
          home: const Login(),
        ),
      ),
    );
  }
}
