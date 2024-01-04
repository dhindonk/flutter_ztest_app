import 'package:flutter/material.dart';
import 'package:z_test/data/controllers/api_page_controller.dart';
import 'package:z_test/data/models/auth_model.dart';

class CardCategory extends StatelessWidget {

  const CardCategory({
    super.key,
    required this.user,
    required this.nextDestination,
    required this.nameCategory,
    required this.questAmount,
    required this.image,
  });

  final Auth user;
  final String nextDestination;
  final String nameCategory, image;
  final int? questAmount;

  @override
  Widget build(BuildContext context) {
    NextDestination next = NextDestination(context);

    return GestureDetector(
      onTap: () {
        if (nextDestination == 'question') {
          next.getDataQuestions(user, context, nameCategory);
        } else {
          // next.userLogin(username, context);
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
                color: Color.fromARGB(77, 196, 196, 196),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      nameCategory,
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 17),
                    child: Text(
                      '$questAmount Questions',
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
                child: Image.asset('assets/icons/$image'),
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
