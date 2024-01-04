import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/core/constants/colors.dart';
import 'package:z_test/data/models/auth_model.dart';
import 'package:z_test/data/models/soal-model.dart';
import 'package:http/http.dart' as myHttp;
import 'package:z_test/presentation/quiz/pages/questions.dart';
import 'package:z_test/presentation/quiz/pages/questions_death.dart';

class NextDestination {
  late SoalModel soalModel;
  final url = dotenv.env['API_URL'];
  final olahraga = dotenv.env['API_OLAHRAGA'];
  final kehidupan = dotenv.env['API_KEHIDUPAN'];
  final selebriti = dotenv.env['API_SELEBRITI'];
  final kuliner = dotenv.env['API_KULINER'];
  final games = dotenv.env['API_GAMES'];
  final musik = dotenv.env['API_MUSIK'];
  final sejarah = dotenv.env['API_SEJARAH'];
  final film = dotenv.env['API_FILM'];
  final teknologi = dotenv.env['API_TEKNOLOGI'];
  final travel = dotenv.env['API_TRAVEL'];
  final kecerdasan = dotenv.env['API_KECERDASAN'];
  final cewek = dotenv.env['API_CEWEK'];
  BuildContext? context;

  NextDestination([this.context]);

  void getDataQuestions(
      Auth user, BuildContext context, String nameCategory) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sabar ya...',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
      );
      if (nameCategory == 'Olahraga') {
        var response = await myHttp.get(Uri.parse('$olahraga'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Ujian Kehidupan') {
        var response = await myHttp.get(Uri.parse('$kehidupan'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Selebriti') {
        var response = await myHttp.get(Uri.parse('$selebriti'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Kuliner') {
        var response = await myHttp.get(Uri.parse('$kuliner'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Video Games') {
        var response = await myHttp.get(Uri.parse('$games'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Musik') {
        var response = await myHttp.get(Uri.parse('$musik'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Sejarah') {
        var response = await myHttp.get(Uri.parse('$sejarah'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Film') {
        var response = await myHttp.get(Uri.parse('$film'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Teknologi') {
        var response = await myHttp.get(Uri.parse('$teknologi'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Travel') {
        var response = await myHttp.get(Uri.parse('$travel'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Uji Kecerdasan') {
        var response = await myHttp.get(Uri.parse('$kecerdasan'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.leftToRight,
        );
      } else if (nameCategory == 'Bahasa Cewek') {
        var response = await myHttp.get(Uri.parse('$cewek'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionsPageNew(
              soalModel: soalModel, user: user, nameCategory: nameCategory),
          transition: Transition.rightToLeft,
        );
      } else if (nameCategory == 'Death Match') {
        var response = await myHttp.get(Uri.parse('$url'));
        soalModel = SoalModel.fromJson(json.decode(response.body));

        Navigator.of(context).pop();

        Get.to(
          QuestionDeathMatch(
            soalModel: soalModel,
            user: user,
            nameCategory: nameCategory,
          ),
          transition: Transition.leftToRight,
        );
      } else {
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sabar ya..',
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        );
        await Future.delayed(Duration(seconds: 2));

        Navigator.of(context).pop();
        final snackBar = SnackBar(
          backgroundColor: red,
          content: const Text('Yahh..Gagal Mengambil Soal'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (err) {
      Navigator.of(context).pop();
      final snackBar = SnackBar(
        backgroundColor: red,
        content: const Text('Periksa Jaringan Anda!!!'),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print(err.toString());
    }
  }
}
