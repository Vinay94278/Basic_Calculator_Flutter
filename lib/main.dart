// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:calc/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(Calc());
}

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator Basic Application",
      home: AnimatedSplashScreen(
        backgroundColor: Colors.black,
        splash: Image.asset("assets/img/logo.png"),
        nextScreen: CalculatorHomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  //variable
  double num1 = 0.0;
  double num2 = 0.0;
  var input = "";
  var output = "";
  var op = "";

  onButtonClicked(val) {
    //if value is clear
    if (val == "Clear") {
      input = "";
      output = "";
    } else if (val == "Del") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      if (input == "") {
        input = "";
        output = "";
      }
    } else if (val == "=") {
      if (input.isNotEmpty) {
        var ui = input;
        ui = input.replaceAll("×", "*");
        Parser p = Parser();
        Expression exp = p.parse(ui);
        ContextModel cm = ContextModel();
        var finalvalue = exp.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + val;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(children: [
          //input output area
          Expanded(
              child: Container(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: 34,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            color: Colors.black,
          )),

          // Button Area
          Container(
            width: double.infinity,
            color: keyBordbg,
            child: Container(
              height: 500,
              color: keyBordbg,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(text: "Clear", co: operatorColor),
                      button(text: "%", co: operatorColor),
                      button(text: "Del", co: operatorColor),
                      button(text: "/", co: operatorColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(text: "7"),
                      button(text: "8"),
                      button(text: "9"),
                      button(text: "×", co: operatorColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(text: "4"),
                      button(text: "5"),
                      button(text: "6"),
                      button(text: "-", co: operatorColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(text: "1"),
                      button(text: "2"),
                      button(text: "3"),
                      button(text: "+", co: operatorColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      button(text: "00"),
                      button(text: "0"),
                      button(text: "."),
                      button(text: "=", co: operatorColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget button({text, co = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        // color: Colors.amber,
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            onButtonClicked(text);
          },
          child: Text(
            text,
            style: TextStyle(
              color: co,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
