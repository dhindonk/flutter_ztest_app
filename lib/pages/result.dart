import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hasil extends StatefulWidget {
  final int hasil;
  const Hasil({super.key, required this.hasil});

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/trophy.png',
                width: 150,
                ),
              
              SizedBox(
                height: 50,
              ),

              Text(
                'Horeee Kamu Kalahhh Skor : '+widget.hasil.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  
                ),
              )
            ],
              ),
        )),
    );
  }
}