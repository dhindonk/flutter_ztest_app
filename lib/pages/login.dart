import 'package:flutter/material.dart';
import 'package:ujian_app/models/get-data.dart';
import 'package:ujian_app/style/button.dart';
import 'package:ujian_app/style/card.dart';
import 'package:ujian_app/style/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  NextDestination next = NextDestination();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.greenAccent,
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  child: Center(
                    child: Container(
                      width: 180,
                      height: 190,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/trophy.png'))),
                    ),
                  ),
                ),
                //

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: TextField(
                            decoration: inputName,
                            controller: usernameController,
                            maxLength: 10,
                            autocorrect: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: buttonStart,
                          onPressed: () {
                            next.userLogin(usernameController.text, context);
                          },
                          child: Text('Start'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
