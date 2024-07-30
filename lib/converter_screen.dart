import 'package:calculator_app/button_values.dart';
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  List<String> converterOptions = [
    'Length',
    'Area',
    'Temperature',
    'Volume',
    'Mass',
    'Speed',
    'Data',
    'Time',
    'Currency'
  ];
  int selectedOption = 0;
  List<String> lengthOptions = ['mm', 'cm', 'm', 'km', 'in', 'ft', 'yd', 'mi'];
  String? currentLength = 'cm';
  List<String> lengthOptions1 = ['mm', 'cm', 'm', 'km', 'in', 'ft', 'yd', 'mi'];
  String? currentLength1 = 'in';
  String initOut = '0';
  String targetOut = '0';
  bool inputReserve = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 80,
              margin: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                value: selectedOption,
                items: converterOptions.map((String value) {
                  return DropdownMenuItem(
                    value: converterOptions.indexOf(value),
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width - 108,
                margin: EdgeInsets.only(left: 8),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                ),
                child: SelectableText(
                  initOut,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                  showCursor: true,
                ),
              ),
              SizedBox(
                width: 100,
                child: Center(
                  child: SizedBox(
                    width: 50,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: currentLength,
                      items: lengthOptions.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          currentLength = value;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width - 108,
                  margin: EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[800]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: SelectableText(
                    initOut,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                    showCursor: true,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: currentLength1,
                        items: lengthOptions1.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            currentLength1 = value;
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Wrap(
                    children: [
                      SizedBox(
                        width: screenSize.width / 2,
                        height: screenSize.width / 5,
                        child: buildButton(Btn.clr, Colors.grey[800]),
                      ),
                      SizedBox(
                        width: screenSize.width / 2,
                        height: screenSize.width / 5,
                        child: buildButton(Btn.sw, Colors.grey[800]),
                      ),
                    ],
                  ),
                  Wrap(
                    children: Btn.convertButtons
                        .map((value) => SizedBox(
                              width: screenSize.width / 3,
                              height: screenSize.width / 5,
                              child: buildButton(value, Colors.grey[900]),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          // buttons
        ],
      ),
    );
  }

  Widget buildButton(String value, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: color,
        clipBehavior: Clip.hardEdge,
        shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: InkWell(
          onTap: () => {},
          child: Center(
            child: value == Btn.sw
                ? Icon(
                    Icons.autorenew,
                    size: 28,
                    color: Colors.grey[300],
                  )
                : value == Btn.del
                    ? RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.grey[300],
                          ),
                        ),
                      )
                    : Text(
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
}
