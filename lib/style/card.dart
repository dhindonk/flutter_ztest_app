import 'package:flutter/material.dart';
import 'package:ujian_app/models/get-data.dart';

class CardCategory extends StatelessWidget {
  const CardCategory(
      {super.key, required this.username, required this.nextDestination});

  final username;
  final String nextDestination;

  @override
  Widget build(BuildContext context) {
    NextDestination next = NextDestination();

    return GestureDetector(
      onTap: () { 
        
        if (nextDestination == 'profile') {
          next.getDataQuestions(username, context);
        } else {
          next.userLogin(username, context);
        }

      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
        child: Stack(
          children: [
            Container(
              width: 160,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      'Mobile Programming',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 17),
                    child: Text(
                      '120 Question',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(5, -20, 0),
              width: 95,
              height: 95,
              child: Container(
                child: Image.asset('assets/trophy.png'),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.2),
                    spreadRadius: -20,
                    blurRadius: 10,
                    offset: Offset(15, 30),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
