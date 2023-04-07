// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';
import 'package:nobook/src/features/notes/subfeatures/calculator/button/buttons.dart';

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'a',
    'x2',
    '^',
    'log',
    'ln',
    'x-1',
    'hyp',
    'sin',
    'cos',
    'tan',
    'SHFT',
    'nCr',
    'Pol(',
    'M+',
    'MODE',
    '7',
    '8',
    '9',
    'DEL',
    'AC',
    '4',
    '5',
    '6',
    'x',
    '/',
    '1',
    '2',
    '3',
    '+',
    '-',
    '0',
    '.',
    'EXP',
    'Ans',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      backgroundColor: const Color.fromRGBO(22, 26, 32, 1),

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 140,
              color: const Color.fromRGBO(48, 51, 63, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.centerRight,
                    color: const Color.fromRGBO(48, 51, 63, 1),
                    child: Text(
                      userInput,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color.fromRGBO(227, 227, 235, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.centerRight,
                    color: const Color.fromRGBO(48, 51, 63, 1),
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(227, 227, 235, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color.fromRGBO(22, 26, 32, 1),
              child: GridView.builder(
                itemCount: buttons.length,
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(255, 86, 86, 1),
                      textColor: Colors.white,
                    );
                  }
                  // Clear Button
                  else if (index == 19) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(255, 86, 86, 1),
                      textColor: Colors.white,
                    );
                  }
                  // Equal_to Button
                  else if (index == 34) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(165, 170, 191, 1),
                      textColor: Colors.white,
                    );
                  }

                  // other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? const Color.fromRGBO(165, 170, 191, 1)
                          : const Color.fromRGBO(36, 41, 51, 1),
                      textColor: Colors.white,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '÷' ||
        x == '()' ||
        x == '%' ||
        x == '^' ||
        x == '!' ||
        x == 'e' ||
        x == 'sin' ||
        x == 'cos' ||
        x == 'tan' ||
        x == 'log' ||
        x == 'SHFT' ||
        x == 'nCr' ||
        x == 'Pol(' ||
        x == 'M+' ||
        x == 'MODE' ||
        x == 'EXP' ||
        x == 'Ans' ||
        x == 'a' ||
        x == 'x2' ||
        x == 'ln' ||
        x == 'x-1' ||
        x == 'hyp') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
