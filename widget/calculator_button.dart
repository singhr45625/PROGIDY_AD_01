import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalculatorButton({
    required this.text,
    required this.fillColor,
    required this.textColor,
    required this.textSize,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 75,
        height: 75,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(fillColor), // Button color
            foregroundColor: Color(textColor), // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(10),
          ),
          onPressed: () => callback(text),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
