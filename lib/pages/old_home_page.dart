import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujian_app/models/get-data.dart';
import 'package:ujian_app/models/soalModel.dart';
import 'package:ujian_app/pages/questions.dart';
import 'package:http/http.dart' as myHttp;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Text(
                'QUIZ',
                style: GoogleFonts.passionOne(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Input Nama Disini!",
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              //
              ElevatedButton(
                  onPressed: () {
                    // getAllData(usernameController.text, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'G A S S S!',
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
