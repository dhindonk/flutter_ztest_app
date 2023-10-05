import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ujian_app/models/soalModel.dart';
import 'package:http/http.dart' as myHttp;
import 'package:ujian_app/pages/dashboard.dart';
import 'package:ujian_app/pages/questions.dart';

class NextDestination {
  late SoalModel soalModel;
  final url = dotenv.env['API_URL'];

  void userLogin(String username, BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Dashboard(username: username)),
    );
  }

//
  void getDataProfile() {}
//
  void getDataQuestions(String username, BuildContext context) async {
    try {
      var response = await myHttp.get(Uri.parse('$url'));
      soalModel = SoalModel.fromJson(json.decode(response.body));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                Questions(soalModel: soalModel, username: username)),
      );
    } catch (err) {
      print(err.toString());
    }
  }
}
