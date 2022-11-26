import 'package:calculator_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(_CalculatorApplication());
}

class _CalculatorApplication extends StatefulWidget {
  _CalculatorApplication({Key? key}) : super(key: key);

  @override
  State<_CalculatorApplication> createState() => __CalculatorApplicationState();
}

class __CalculatorApplicationState extends State<_CalculatorApplication> {
  var inputUser = "";
  var result = "";
  void buttompressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundcolor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttompressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextcolor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundcolor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttompressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextcolor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundcolor(text3)),
          onPressed: () {
            buttompressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextcolor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundcolor(text4)),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
              expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttompressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextcolor(text4),
              ),
            ),
          ),
        )
      ],
    );
  }

  bool isOprator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    ;
    return false;
  }

  Color getBackgroundcolor(String text) {
    if (isOprator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextcolor(String text) {
    if (isOprator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 28,
                              color: textGreen,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(result,
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 38.0,
                            ),
                            textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    height: 200.0,
                    color: backgroundGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow('ac', 'ce', '%', '/'),
                        getRow('7', '8', '9', '*'),
                        getRow('6', '5', '4', '-'),
                        getRow('3', '2', '1', '+'),
                        getRow('00', '0', '.', '='),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
