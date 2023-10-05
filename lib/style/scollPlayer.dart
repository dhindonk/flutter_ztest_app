import 'package:flutter/material.dart';

class PlayerTop extends StatelessWidget {
  const PlayerTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('1'),
            Container(
              width: 200,
              height: 100,
              child: Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Fahdin'),
                ],
              ),
            ),
            Text('1200')
          ],
        ),
      ),
    );
  }
}
