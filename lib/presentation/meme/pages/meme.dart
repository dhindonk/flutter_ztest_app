import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemePage extends StatefulWidget {
  const MemePage({Key? key}) : super(key: key);

  @override
  State<MemePage> createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  final randomIndex = Random().nextInt(102);
  int time = 4;

  void timer(BuildContext context) async {
    if (time > 0) {
      for (var i = 0; i < 4; i++) {
        time--;
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    timer(context);
    print('----------------------');
    print(randomIndex);
    print('----------------------');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 450,
                  width: 450,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                        'assets/images/meme/meme ($randomIndex).jpeg'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Tunggu dalam ${time} ..',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
