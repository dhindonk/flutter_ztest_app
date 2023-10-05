import 'package:flutter/material.dart';
import 'package:ujian_app/pages/first_page.dart';
import 'package:ujian_app/pages/home.dart';
import 'package:ujian_app/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ujian_app/pages/leaderboard.dart';

void main() async{
  await dotenv.load();
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZTest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: FirstPage(),
    );
  }
}