import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/data/data/auth_local_datasource.dart';
import 'package:z_test/presentation/home/pages/dashboard_page.dart';
import 'package:z_test/core/constants/colors.dart';

import '../../../data/models/auth_model.dart';
import 'package:just_audio/just_audio.dart';

class ResultPage extends StatefulWidget {
  ResultPage({
    Key? key,
    required this.score,
    required this.user,
  }) : super(key: key);

  final int score;
  final Auth user;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int newScore;
  final _100 = AudioPlayer();
  final _89 = AudioPlayer();
  final _39 = AudioPlayer();

  Future<void> under100() async {
    await _100.setAsset('assets/audio/Under100.mp3');
    _100.play();
  }

  Future<void> under89() async {
    await _89.setAsset('assets/audio/Under89.mp3');
    _89.play();
  }

  Future<void> under39() async {
    await _39.setAsset('assets/audio/Under39.mp3');
    _39.play();
  }

  void soundEffect() {
    if (widget.score >= 90 && widget.score <= 100) {
      under100();
    } else if (widget.score <= 89 && widget.score >= 40) {
      under89();
    } else if (widget.score <= 39 && widget.score >= 0) {
      under39();
    }
  }

  @override
  void initState() {
    super.initState();
    newScore = widget.user.score! + widget.score;
    soundEffect();

  }

  void updateScore() async {
    await DatabaseHelper.instance.setScore(
      widget.user.id!,
      newScore,
    );
    Auth updatedScore = Auth(
      id: widget.user.id,
      fullName: widget.user.fullName,
      email: widget.user.email,
      password: widget.user.password,
      image: widget.user.image,
      score: newScore,
      token: widget.user.token,
    );

    await DatabaseHelper.instance.updateScore(updatedScore);

 
    Get.offAll(
      () => Dashboard(user: updatedScore),
      transition: Transition.cupertino,
    );
    _100.stop();
    _89.stop();
    _39.stop();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: Container(),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              updateScore();
            },
            icon: SvgPicture.asset(
              'assets/icons/cancel.svg',
              // ignore: deprecated_member_use
              color: primary,
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(switch (widget.score) {
                      >= 90 && <= 100 => 'assets/icons/100.png',
                      <= 89 && >= 40 => 'assets/icons/under50.png',
                      <= 39 && >= 0 => 'assets/icons/under10.png',
                      int() => 'assets/icons/under10.png'
                    })),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Selamat ${widget.user.fullName}, anda telah menyelesaikan quiz dengan baik.',
                      style: GoogleFonts.quicksand(
                        color: black,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skor anda ',
                          style: GoogleFonts.quicksand(
                            color: black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.score.toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: switch (widget.score) {
                              >= 90 && <= 100 => ungu,
                              <= 89 && >= 40 => merah,
                              <= 39 && >= 0 => kuning,
                              int() => green,
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Share',
                //     style: GoogleFonts.quicksand(
                //       color: white,
                //       fontWeight: FontWeight.w800,
                //     ),
                //   ),
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStatePropertyAll(
                //       switch (widget.score) {
                //         >= 90 && <= 100 => ungu,
                //         <= 89 && >= 40 => merah,
                //         <= 39 && >= 0 => kuning,
                //         int() => green,
                //       },
                //     ),
                //     shadowColor: MaterialStatePropertyAll(black),
                //   ),
                // ),
                Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
