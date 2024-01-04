import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionButton extends StatelessWidget {
  OptionButton({
    super.key,
    required this.text,
    required this.pilihan,
    required this.color,
  });

  final String text;
  final String pilihan;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 300,
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: color, width: 2.0),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              color: color,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    pilihan,
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '$text',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
