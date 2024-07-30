import 'package:calculator_app/button_values.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";

  String historyResult = "";

  void onBtnTap(String value) {
    setState(() {
      if (value == Btn.clr) {
        // clear
        if (result != "0" && equation != "0") {
          historyResult = result;
        }
        equation = "0";
        result = "0";
      } else if (value == Btn.del) {
        // delete
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (value == Btn.his) {
        // history
        if (historyResult.isNotEmpty) {
          result = historyResult;
          historyResult = "";
        }
      } else if (value == Btn.absolute) {
        // absolute
        if (result[0] != "-") {
          result = "-$result";
        } else {
          result = result.substring(1);
        }
      } else if (value == Btn.per) {
        // percentage
        equation = "$equation×0.01";
        result = (double.parse(result) / 100).toString();
      } else if (value == Btn.add ||
          value == Btn.subtract ||
          value == Btn.multiply ||
          value == Btn.divide) {
        // add, subtract, multiply, divide
        if (equation == "0") {
          equation = result;
        }
        if (equation[equation.length - 1] == "+" ||
            equation[equation.length - 1] == "-" ||
            equation[equation.length - 1] == "×" ||
            equation[equation.length - 1] == "÷") {
          equation = equation.substring(0, equation.length - 1);
        }
        equation += value;
      } else if (value == Btn.dot) {
        // dot
        List<String> split = equation.split(RegExp(r"[-+×÷]"));

        if (split[split.length - 1].contains(".")) {
          return;
        }
        equation += value;
      } else if (value == Btn.calculate) {
        // calculate
        // generate expression from equation here
        expression = equation.replaceAll("×", "*").replaceAll("÷", "/");
        try {
          // using math_expressions package to evaluate the expression
          // https://pub.dev/packages/math_expressions
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          String currentResult = exp.evaluate(EvaluationType.REAL, cm).toString();
          if (result.isNotEmpty && result != "0") {
            historyResult = result;
          }
          result = currentResult;
        } catch (e) {
          result = "Error";
        }
      } else if (value == Btn.dot) {
        // dot
        if (!equation.contains(".")) {
          equation += value;
        }
      } else {
        if (equation == "0") {
          equation = value;
        } else {
          equation += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Visibility(
                      visible: historyResult.isNotEmpty,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 26,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            ),
                            onPressed: () => onBtnTap(Btn.his),
                            icon: Icon(
                              Icons.access_time,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            iconAlignment: IconAlignment.start,
                            label: Text(
                              historyResult,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      color: Colors.grey[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              iconSize: 20,
                              color: Colors.grey[600],
                              icon: const Icon(Icons.u_turn_left_sharp),
                              onPressed: () => onBtnTap(Btn.del),
                            ),
                          ),
                          Text(
                            equation,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // buttons
            Wrap(
              children: Btn.buttonValues
                  .map((value) => SizedBox(
                        width: value == Btn.n0
                            ? screenSize.width / 2
                            : screenSize.width / 4,
                        height: screenSize.width / 5,
                        child: buildButton(value),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 28,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? getBtnColor(String value) {
    if ([Btn.clr, Btn.absolute, Btn.per].contains(value)) {
      return Colors.grey[800];
    }
    if ([Btn.add, Btn.multiply, Btn.divide, Btn.subtract, Btn.calculate]
        .contains(value)) {
      return Colors.blue[800];
    }
    return Colors.grey[900];
  }
}
