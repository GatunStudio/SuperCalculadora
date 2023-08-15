import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const titleString = 'Super Calculadora';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleString,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 255, 192, 90))
            .copyWith(
          primary: const Color.fromARGB(255, 96, 104, 150),
          secondary: const Color.fromARGB(255, 93, 122, 176),
          tertiary: const Color.fromARGB(255, 181, 253, 210),
          onPrimary: const Color.fromARGB(255, 169, 172, 232),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. Color.fromARGB(255, 83, 119, 218)es (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _result = 0;
  String _operation = '+';

  void _incrementCounter(final int number) {
    if (_result == 0 || number == 0) {
      setState(() {
        _result = number;
      });
    } else {
      if (_operation == '+') {
        setState(() {
          _result = _result + number;
        });
      } else if (_operation == '-') {
        setState(() {
          _result = _result - number;
        });
      } else if (_operation == '*') {
        setState(() {
          _result = _result * number;
        });
      } else if (_operation == '%') {
        setState(() {
          _result = _result % number;
        });
      } else {
        setState(() {
          _result = (_result / number).round();
        });
      }
    }
  }

  void _changeOperator(final String operator) {
    setState(() {
      _operation = operator;
    });
  }

  // number from 0 to 10

  final List<String> _operators = ['+', '-', '*', '/', '%'];
  final List<int> _numbers = List<int>.generate(10, (i) => i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(titleString,
            style: TextStyle(
                color: Color.fromARGB(255, 244, 245, 254),
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                width: MediaQuery.of(context).size.width > 450
                    ? 450
                    : double.infinity,
                child: Text(
                  '$_result $_operation',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: MediaQuery.of(context).size.width > 450
                      ? 450
                      : double.infinity,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [..._operators, ..._numbers]
                        .map((number) => Container(
                            margin: const EdgeInsets.all(5),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    _operators.contains(number) || number == 0
                                        ? MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .inversePrimary)
                                        : MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                iconSize: MaterialStateProperty.all<double>(10),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.primary),
                              ),
                              onPressed: () {
                                if (_operators.contains(number)) {
                                  _changeOperator(number as String);
                                } else {
                                  _incrementCounter(number as int);
                                }
                              },
                              child: Text(
                                '$number',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            )))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
