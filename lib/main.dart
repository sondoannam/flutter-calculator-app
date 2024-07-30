import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:calculator_app/calculator_screen.dart';
import 'package:calculator_app/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const FinalView(),
    );
  }
}

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: screenSize.width,
              margin: const EdgeInsets.fromLTRB(4, 20, 4, 0),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[800],
              ),
              child: ButtonsTabBar(
                height: 40,
                width: (screenSize.width - 8) / 2,
                contentCenter: true,
                buttonMargin: const EdgeInsets.all(0),
                backgroundColor: Colors.blue[800],
                unselectedBackgroundColor: Colors.grey[800],
                unselectedLabelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                tabs: const [
                  Tab(
                    text: "Calculator",
                  ),
                  Tab(
                    text: "Converter",
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CalculatorScreen(),
                  ConverterScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
