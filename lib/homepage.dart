// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _expression = "";
  String _result = "";

// Function when the button is pressed
  void _onPressed(String text) {
    setState(() {
      if (text == "=") {
        _evaluateexp(); // When = is pressed value is evaluated using evaluateexp function
      } else if (text == "C") {
        _clear(); // when c is pressed value is cleared
      } else {
        _expression += text; // else input is added to the display
      }
    });
  }

//function to evaluate value
  void _evaluateexp() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      _result = 'Error';
    }
  }

  //function to clear display
  void _clear() {
    _expression = "";
    _result = "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ( This is to get the the height and width with respect to the screen)
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(12),
            height: 600,
            // width: Get.width * 0.8,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.blue[300],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 100,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _expression.isEmpty ? '0' : _expression,
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                        Text(
                          _result.isEmpty ? '0' : "=$_result",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Expanded(
                  flex: 3,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      List<String> buttonTexts = [
                        '7',
                        '8',
                        '9',
                        '/',
                        '4',
                        '5',
                        '6',
                        '*',
                        '1',
                        '2',
                        '3',
                        '-',
                        '.',
                        '0',
                        '=',
                        '+',
                        'C',
                        '(',
                        ')',
                        '<<',
                      ];
                      return GestureDetector(
                        onTap: () {
                          _onPressed(buttonTexts[index]);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            buttonTexts[index],
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
