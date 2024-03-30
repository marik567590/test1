import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController _inputController = TextEditingController();
  String _output = '';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operation = '';
  bool _isOperationChosen = false;
  bool _isKilometers = true;
  List<String> _history = [];

  void _calculate(String value) {
    if (value == 'C') {
      setState(() {
        _inputController.text = '';
        _output = '';
        _num1 = 0.0;
        _num2 = 0.0;
        _operation = '';
        _isOperationChosen = false;
      });
    } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
      setState(() {
        _num1 = double.parse(_inputController.text);
        _operation = value;
        _isOperationChosen = true;
        _inputController.text = '';
      });
    } else if (value == '=') {
      setState(() {
        _num2 = double.parse(_inputController.text);
        double result = 0.0;
        switch (_operation) {
          case '+':
            result = _num1 + _num2;
            break;
          case '-':
            result = _num1 - _num2;
            break;
          case '×':
            result = _num1 * _num2;
            break;
          case '÷':
            result = _num1 / _num2;
            break;
        }
        _output = result.toString();
        _inputController.text = _output;
        _history.add('$_num1 $_operation $_num2 = $_output');
        _isOperationChosen = false;
      });
    } else if (value == 'Км ⇄ Мили') {
      setState(() {
        _isKilometers = !_isKilometers;
        _output = '';
        _inputController.text = '';
        _history.clear();
      });
    } else {
      setState(() {
        if (_isOperationChosen) {
          _inputController.text = '';
          _isOperationChosen = false;
        }
        _inputController.text = _inputController.text + value;
      });
    }
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          _calculate(value);
        },
        child: Text(
          value,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: TextField(
                controller: _inputController,
                readOnly: true,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 32.0),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('÷'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('×'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _calculate('Км ⇄ Мили');
                  },
                  child: Text(
                    'Км ⇄ Мили',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _history[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
