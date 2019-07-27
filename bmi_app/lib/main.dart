import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Please, input your data.";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      String _infoText = "Please, input your data.";
      _formKey = GlobalKey<FormState>(); //reset formkey to reload data corectly
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      if (bmi < 18.6) {
        _infoText = "Low weight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Right weight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Overweight (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesity I (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "Obesity II (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 40.0) {
        _infoText = "Obesity III (${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.black38,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.black38),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black38, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Input your weight.";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (cm)",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black38, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Input your height.";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.black38,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black38, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
