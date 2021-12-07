import 'package:flutter/material.dart';

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
            const Spacer(),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: 'C', callback: (String value) {}),
                      Button(text: '\$', callback: (String value) {}),
                      Button(text: '%', callback: (String value) {}),
                      Button(
                          text: '/',
                          isCircle: true,
                          callback: (String value) {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: '7', callback: (String value) {}),
                      Button(text: '8', callback: (String value) {}),
                      Button(text: '9', callback: (String value) {}),
                      Button(
                          text: '-',
                          isCircle: true,
                          callback: (String value) {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: '4', callback: (String value) {}),
                      Button(text: '5', callback: (String value) {}),
                      Button(text: '6', callback: (String value) {}),
                      Button(
                          text: '+',
                          isCircle: true,
                          callback: (String value) {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: '1', callback: (String value) {}),
                      Button(text: '2', callback: (String value) {}),
                      Button(text: '3', callback: (String value) {}),
                      Button(
                          text: 'x',
                          isLarge: false,
                          isCircle: true,
                          callback: (String value) {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                          text: '0',
                          isLarge: true,
                          callback: (String value) {}),
                      Button(text: '.', callback: (String value) {}),
                      Button(
                          text: '=',
                          isCircle: true,
                          callback: (String value) {}),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
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
  final int textColor;
  final Function callback;
  const Button(
      {required this.text,
      this.isLarge = false,
      this.isCircle = false,
      this.textColor = 0xFFFFFFFF,
      required this.callback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, right: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
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
