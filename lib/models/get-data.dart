import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ujian_app/models/soalModel.dart';
import 'package:http/http.dart' as myHttp;
import 'package:ujian_app/pages/home.dart';
import 'package:ujian_app/pages/tes_page.dart';

late SoalModel soalModel;
final url = dotenv.env['API_URL'];

void getAllData(String username, BuildContext context) async {
  try {
    var response = await myHttp.get(Uri.parse('$url'));
    soalModel = SoalModel.fromJson(json.decode(response.body));

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Home(username: username)
          // Start(
          //   soalModel: soalModel,
          //   username: username,
          // ),
          ),
    );
  } catch (err) {
    print(err.toString());
  }
}

void userStart(String username, BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => Home(username: username)),
  );
}
