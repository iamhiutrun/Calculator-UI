import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = '123';
  var answer = '';

  final List<String> _buttons = [
    'c',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void onEqualButtonPressed() {
    String calculation = userInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(calculation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const Spacer(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(userInput,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                dragStartBehavior: DragStartBehavior.start,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // C button
                    return Button(
                      text: _buttons[0],
                      callback: (value) {
                        setState(() {
                          userInput = '';
                          answer = '';
                        });
                      },
                    );
                  } else if (index == 1) {
                    // negate userInput
                    return Button(
                      text: _buttons[1],
                      callback: (value) {
                        setState(() {
                          userInput = '-(' + userInput + ')';
                        });
                      },
                    );
                  } else if (index == 3) {
                    return Button(
                      text: _buttons[3],
                      callback: (value) {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                    );
                  } else if (index == 18) {
                    // = button
                    return Button(
                      color: Colors.green,
                      text: _buttons[18],
                      callback: (value) {
                        setState(() {
                          onEqualButtonPressed();
                        });
                      },
                    );
                  } else {
                    // other buttons
                    return Button(
                      text: _buttons[index],
                      color: isOperator(_buttons[index])
                          ? Colors.red
                          : Colors.black,
                      callback: (value) {
                        setState(() {
                          userInput += value;
                        });
                      },
                    );
                  }
                },
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final bool isLarge;
  final bool isCircle;
  final Color? color;
  final Function callback;
  const Button(
      {required this.text,
      this.isLarge = false,
      this.isCircle = false,
      required this.callback,
      Key? key,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, right: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: color ?? Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(isCircle ? 30 : 10))),
      width: isLarge ? 140 : 65,
      height: 65,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isCircle ? 30 : 10),
                    side: const BorderSide(color: Colors.grey)))),
        onPressed: () {
          callback(text);
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
