import 'package:flutter/material.dart';
import 'package:ujian_app/style/scollPlayer.dart';


class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});


  @override
  Widget build(BuildContext context) {
  var _title = Text('Leaderboard');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          title: _title,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Icon(Icons.share),
            )
          ],
        ),
        body: Column(
          children: [
            // LeadTop
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 200,
                    // color: Colors.greenAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: Image.asset('assets/trophy.png'),
                            ),
                            Image.asset('assets/border.png'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fahdin',
                          style: TextStyle(
                              letterSpacing: 3,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          'Score : 12000',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white54,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 145,
                    height: 200,
                    // color: Colors.greenAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: Image.asset('assets/trophy.png'),
                            ),
                            Image.asset('assets/border.png'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fahdin',
                          style: TextStyle(
                              letterSpacing: 3,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          'Score : 12000',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white54,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 200,
                    // color: Colors.greenAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: Image.asset('assets/trophy.png'),
                            ),
                            Image.asset('assets/border.png'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fahdin',
                          style: TextStyle(
                              letterSpacing: 3,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          'Score : 12000',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white54,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //
            Expanded(
              child: ListView(
                children: [
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                  PlayerTop(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
