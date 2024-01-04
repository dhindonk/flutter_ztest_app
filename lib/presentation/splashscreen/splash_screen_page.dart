import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:z_test/core/constants/colors.dart';

import '../../data/controllers/splashscreen_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitSquareCircle(
              color: Colors.transparent,
              size: 50,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 250,
            ),
            SizedBox(height: 50),
            SpinKitChasingDots(
              color: primary,
              size: 30.0,
              duration: Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}
