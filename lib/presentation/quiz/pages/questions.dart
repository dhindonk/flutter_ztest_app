// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/presentation/meme/pages/meme.dart';
import 'package:z_test/data/models/soal-model.dart';
import 'package:z_test/core/components/custom_button_quiz.dart';
import 'package:z_test/presentation/result/pages/result.dart';
import 'package:z_test/core/constants/colors.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/auth_model.dart';

class QuestionsPageNew extends StatefulWidget {
  final soalModel;
  final Auth user;
  final String nameCategory;
  QuestionsPageNew({
    Key? key,
    required this.user,
    required this.soalModel,
    required this.nameCategory,
  }) : super(key: key);

  @override
  State<QuestionsPageNew> createState() => _QuestionsPageNewState();
}

class _QuestionsPageNewState extends State<QuestionsPageNew> {
  late SoalModel jawabanAkhir;
  final backsound = AudioPlayer();

  int index = 0;
  int indexSoal = 0;
  int hasil = 0;
  bool nyerah = false, onClickFlag = true;

  List<int> shuffledIndexes = [];

  Future<void> playBg() async {
    backsound.setAsset('assets/audio/backsound.mp3');
    backsound.play();
    backsound.setLoopMode(LoopMode.all);
  }

  Future<void> tapped(String jawaban) async {
    if (indexSoal < widget.soalModel.data.length) {
      int shuffledIndex = shuffledIndexes[indexSoal];

      bool isJawabanBenar =
          (jawaban == widget.soalModel.data[shuffledIndex].kunciJawaban);

      setState(() {
        if (isJawabanBenar) {
          hasil += 5;
          print('KUNCI : ' + widget.soalModel.data[shuffledIndex].kunciJawaban);
          print('KLIK : ' + jawaban);
          print(' --------------- Jawaban Benar --------------- ');
        } else {
          print('KUNCI : ' + widget.soalModel.data[shuffledIndex].kunciJawaban);
          print('KLIK : ' + jawaban);
          print(' --------------- SALAH --------------- ');
        }

        indexSoal++;

        if (indexSoal < widget.soalModel.data.length) {
          index = shuffledIndexes[indexSoal];
        } else {
          Get.offAll(
            ResultPage(score: hasil, user: widget.user),
            transition: Transition.cupertino,
          );
          backsound.stop();
        }
      });
    }
  }

  void firstTap(String jawaban) async {
    await Get.to(
      MemePage(),
      transition: Transition.zoom,
    );

    tapped(jawaban);
  }

  @override
  void initState() {
    super.initState();
    playBg();
    shuffledIndexes = List<int>.generate(
      widget.soalModel.data.length,
      (index) => index,
    )..shuffle();

    index = shuffledIndexes[0];

    print(shuffledIndexes);
  }

  Future<void> nyerahBang() async {
    setState(() {
      nyerah = !nyerah;
      onClickFlag = !onClickFlag;
    });
    await Future.delayed(Duration(seconds: 2));
    Get.offAll(
      ResultPage(score: hasil, user: widget.user),
      transition: Transition.cupertino,
    );
    backsound.stop();
    setState(() {
      nyerah = !nyerah;
      onClickFlag = !onClickFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.scale,
          title: "Confirm Cancel",
          desc: "Are you sure you want to cancel?",
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            Get.back(canPop: true);
            backsound.stop();
          },
        )..show();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: primary,
            leading: IconButton(
              tooltip: 'Kembali',
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: white,
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.scale,
                  title: "Confirm Cancel",
                  desc: "Are you sure you want to cancel?",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    Get.back();
                    backsound.stop();
                  },
                )..show();
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      'Kategori : ',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.nameCategory,
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      physics: BouncingScrollPhysics(),
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        InkWell(
                          onTap: () {
                            firstTap('a');
                          },
                          child: OptionButton(
                            text: widget.soalModel.data[index].pilihanA
                                .toString(),
                            pilihan: 'A',
                            color: red,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            firstTap('b');
                          },
                          child: OptionButton(
                            text: widget.soalModel.data[index].pilihanB
                                .toString(),
                            pilihan: 'B',
                            color: black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            firstTap('c');
                          },
                          child: OptionButton(
                            text: widget.soalModel.data[index].pilihanC
                                .toString(),
                            pilihan: 'C',
                            color: purple,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            firstTap('d');
                          },
                          child: OptionButton(
                            text: widget.soalModel.data[index].pilihanD
                                .toString(),
                            pilihan: 'D',
                            color: green,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              (onClickFlag) ? nyerahBang() : onClickFlag,
                          child: nyerah == false
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Nyerah Bang',
                                      style: GoogleFonts.quicksand(
                                        color: white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Transform.rotate(
                                      angle: -.3,
                                      child: Image.asset(
                                        'assets/icons/white-flag.png',
                                        width: 20,
                                      ),
                                    )
                                  ],
                                )
                              : Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: white,
                                    ),
                                  ),
                                ),
                          style: ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              backgroundColor: MaterialStatePropertyAll(red)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 2 - 180,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        width: 335,
                        height: 250,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Soal ',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                  ),
                                  Text(
                                    indexSoal < widget.soalModel.data.length
                                        ? (indexSoal + 1).toString()
                                        : (indexSoal)
                                            .toString(), // Perubahan di sini
                                    style: GoogleFonts.quicksand(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                  ),
                                  Text(
                                    ' / ${widget.soalModel.data.length.toString()}',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 300,
                                // color: Colors.red,
                                child: Text(
                                  widget.soalModel.data[index].pertanyaan
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black45),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -50,
                      left: 120,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CountDownProgressIndicator(
                            valueColor: primary,
                            backgroundColor: secoundry,
                            initialPosition: 0,
                            duration: 300,
                            text: 'Detik',
                            labelTextStyle: GoogleFonts.quicksand(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: primary,
                            ),
                            strokeWidth: 4,
                            timeTextStyle: GoogleFonts.quicksand(
                              fontSize: 30,
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                            onComplete: () {
                              Get.off(
                                ResultPage(score: hasil, user: widget.user),
                              );
                              backsound.stop();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
