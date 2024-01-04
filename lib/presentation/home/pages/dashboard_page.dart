import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/core/constants/colors.dart';
import 'package:z_test/data/data/auth_local_datasource.dart';
import 'package:z_test/presentation/profile/pages/profile.dart';
import 'package:z_test/core/components/card_category.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/auth_model.dart';

class Dashboard extends StatefulWidget {
  final Auth user;

  Dashboard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('----------> ${widget.user.image}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.scale,
          title: "Confirm Exit",
          desc: "Are you sure you want to exit?",
          titleTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          descTextStyle: GoogleFonts.quicksand(),
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            Get.back(canPop: true);
            SystemNavigator.pop();
          },
        )..show();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${widget.user.fullName ?? ''}',
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Quiz berhadiah HAJI / UMRAH',
                            style: GoogleFonts.quicksand(),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          
                          Get.to(
                            () => ProfilePage(user: widget.user),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primary),
                          child: ClipOval(
                            child: Container(
                              clipBehavior: Clip.none,
                              width: 50,
                              height: 50,
                              color: white,
                              child: widget.user.image != null
                                  ? Image.file(
                                      File(widget.user.image!),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/profile.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(171, 46, 29, 92),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.scale,
                              title: "COMING SOON",
                              desc: "Terima kasih telah menunggu :)",
                            )..show();
                          },
                          child: Container(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.travel_explore_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rangking',
                                        style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Coming soon',
                                        style: GoogleFonts.quicksand(
                                          // fontSize: 19,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 15,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        InkWell(
                          onTap: () async {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.scale,
                              title: "COMING SOON",
                              desc: "Terima kasih telah menunggu :)",
                            )..show();
                          },
                          child: Container(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Score',
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        widget.user.score.toString(),
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('K A T E G O R I',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Olahraga',
                                questAmount: 20,
                                image: 'sports.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Selebriti',
                                questAmount: 20,
                                image: 'celebrity.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Video Games',
                                questAmount: 20,
                                image: 'game-controller.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Sejarah',
                                questAmount: 20,
                                image: 'history.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Teknologi',
                                questAmount: 20,
                                image: 'chip.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Uji Kecerdasan',
                                questAmount: 20,
                                image: 'idea.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Death Match',
                                questAmount: 100,
                                image: 'death.png',
                              ),
                            ],
                          ),
                          //
                          Column(
                            children: [
                              SizedBox(
                                width: 0,
                                height: 50,
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Ujian Kehidupan',
                                questAmount: 20,
                                image: 'checklist.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Kuliner',
                                questAmount: 20,
                                image: 'dish.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Musik',
                                questAmount: 20,
                                image: 'guitar.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Film',
                                questAmount: 20,
                                image: 'movie.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Travel',
                                questAmount: 20,
                                image: 'travel.png',
                              ),
                              CardCategory(
                                user: widget.user,
                                nextDestination: 'question',
                                nameCategory: 'Bahasa Cewek',
                                questAmount: 20,
                                image: 'self-esteem.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
