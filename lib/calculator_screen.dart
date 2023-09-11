import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  //
void onButtonPressed(String buttonText){
  setState(() {
    if(buttonText == '='){
      try {
        Parser p = Parser();
        Expression exp = p.parse(input);
        ContextModel cm = ContextModel();
        result = exp.evaluate(EvaluationType.REAL, cm).toString();
      }
      catch(e){
        result = 'Invalid';
      }
    }
    else if(buttonText == 'C'){
      input = '';
      result = '';
    }
    else if(buttonText == "<-")
    {
      if(buttonText.isNotEmpty){
         input = input.substring(0,input.length -1);
      }
     
    }

    else{
      input += buttonText;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Basic Calculator',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 68, 57, 6)
        ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
              Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              input.isEmpty ? "0" : input,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        // Expanded Text for result
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 249, 224, 3)
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2/1.6,
                
                ),
                itemBuilder: (context, index) {
                  final buttonText = buttonLabels[index];
                  return TextButton(
                    onPressed: () => onButtonPressed(buttonText),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.amber,
                      ),
                    ),
                    );
                },
                itemCount: buttonLabels.length,
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> buttonLabels = [
   '<-',' ',' ','C',
   '7', '8', '9', '/',
   '4', '5', '6', '*',
   '1', '2', '3', '-',
   '.', '0', '=', '+',
];
