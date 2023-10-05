import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ujian_app/models/get-data.dart';
import 'package:ujian_app/pages/profile.dart';
import 'package:ujian_app/pages/questions.dart';
import 'package:ujian_app/style/card.dart';

class Dashboard extends StatelessWidget {
  final username;
  const Dashboard({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          'Hi, $username',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text('Quiz berhadiah umrah')
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 30,
                      ),
                    )
                  ],
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 110,
                          height: 60,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.travel_explore_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rangking'),
                                  Text(
                                    '1500',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 110,
                          height: 60,
                          // color: Colors.greenAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.travel_explore_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rangking'),
                                  Text(
                                    '1500',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //
              // Container(
              //   width: double.infinity,
              //   height: ,
              //   color: Colors.redAccent,
              // )
              SizedBox(
                height: 10,
              ),
              Text('K A T E G O R Y',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),

              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CardCategory(username: username, nextDestination: 'profile',),
                          ],
                        ),
                        //
                        Column(
                          children: [
                            SizedBox(
                              width: 0,
                              height: 50,
                            ),
                            // CardCategory(username: username, nextDestination: Questions(soalModel: soalModel, username: username)),
                            
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
    );
  }
}
