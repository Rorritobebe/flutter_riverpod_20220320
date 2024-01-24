import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String operator = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          // Display for equation and result
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(equation, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Text(result, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),

          // Grid of buttons for numbers and operators
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                // Numbers
                for (int i = 0; i <= 9; i++)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        equation += i.toString();
                      });
                    },
                    child: Text(i.toString()),
                  ),

                // Operators
                TextButton(
                  onPressed: () {
                    setState(() {
                      operator = '+';
                    });
                  },
                  child: const Text('+'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      operator = '-';
                    });
                  },
                  child: const Text('-'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      operator = '*';
                    });
                  },
                  child: const Text('*'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      operator = '/';
                    });
                  },
                  child: const Text('/'),
                ),

                // Equals button
                TextButton(
                  onPressed: () {
                    // Calculate the result
                    double num1 = double.parse(equation.substring(0, equation.length - 1));
                    double num2 = double.parse(equation.substring(equation.length - 1));
                    switch (operator) {
                      case '+':
                        result = num1 + num2.toString();
                        break;
                      case '-':
                        result = num1 - num2.toString();
                        break;
                      case '*':
                        result = num1 * num2.toString();
                        break;
                      case '/':
                        result = num1 / num2.toString();
                        break;
                    }
                    // Clear the equation
                    equation = '';
                  },
                  child: const Text('='),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
