import 'package:flutter/material.dart';
import 'package:z_test/imagePicker.dart';
import 'package:z_test/presentation/auth/pages/login_register_page.dart';
import 'package:z_test/presentation/splashscreen/splash_screen_page.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
 
    return GetMaterialApp(
      title: 'ZTest',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
