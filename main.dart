import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/calculator_button.dart'; // Import the button widget
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String userInput = '';
  String result = '0';

  // Function to handle button presses
  void buttonPressed(String text) {
    setState(() {
      if (text == "AC") {
        userInput = '';
        result = '0';
      } else if (text == "C" || text == "<") { // Fixed delete button "<"
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (text == "=") {
        try {
          result = evaluateExpression(userInput);
        } catch (e) {
          result = "Error";
        }
      } else {
        userInput += text;
      }
    });
  }

  // Function to evaluate expressions
  String evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(expression);

      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Formatting result to avoid long decimal numbers
      return evalResult.toStringAsFixed(5).replaceAll(RegExp(r'\.?0*$'), '');
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.grey[800]),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display Area
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: GoogleFonts.rubik(fontSize: 32, color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: GoogleFonts.rubik(fontSize: 40, color: Colors.black),
            ),
          ),

          // Buttons Area
          Column(
            children: [
              buildButtonRow(["AC", "C", "<", "÷"]),
              buildButtonRow(["7", "8", "9", "×"]),
              buildButtonRow(["4", "5", "6", "-"]),
              buildButtonRow(["1", "2", "3", "+"]),
              buildButtonRow(["00", "0", ".", "="]),
            ],
          ),
        ],
      ),
    );
  }

  // Function to build rows of buttons
  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return CalculatorButton(
          text: text,
          fillColor: text == "AC" || text == "C"
              ? 0xFFBDBDBD
              : text == "="
              ? 0xFFf4d160
              : 0xFF616161,
          textColor: text == "=" ? 0xFF424242 : 0xFFFFFFFF,
          textSize: 24,
          callback: buttonPressed,
        );
      }).toList(),
    );
  }
}
