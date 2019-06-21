import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
      title: "Simple Interest App",
      home: SIForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent)));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  List<String> _currencies = ["Rupees", "Dollars", "Pounds"];
  String _currencySelected = "";
  final double _minimumPadding = 5.0;

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  @override
  void initState() {
    super.initState();
    this._currencySelected = this._currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest App"),
      ),
      body: Container(
        padding: EdgeInsets.all(this._minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            this.getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                  top: this._minimumPadding, bottom: this._minimumPadding),
              child: TextField(
                controller: principalController,
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: "Principal",
                  labelStyle: textStyle,
                  hintText: "Enter Principal e.g. 12000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(this._minimumPadding),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: this._minimumPadding, bottom: this._minimumPadding),
              child: TextField(
                controller: roiController,
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: "Rate Interest",
                  labelStyle: textStyle,
                  hintText: "In percent",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(this._minimumPadding),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: this._minimumPadding, bottom: this._minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: termController,
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: "Terms",
                        labelStyle: textStyle,
                        hintText: "In year",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(this._minimumPadding),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: this._minimumPadding * 5,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    items: this._currencies.map((currency) {
                      return DropdownMenuItem<String>(
                        child: Text(currency),
                        value: currency,
                      );
                    }).toList(),
                    onChanged: (String onValueChanged) {
                      _onDropdownItemSelected(onValueChanged);
                    },
                    value: this._currencySelected,
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: this._minimumPadding, bottom: this._minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            this.displayResult = this._calculatePayment();
                          });
                        }),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          this._reset();
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(this._minimumPadding * 2),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/currency-icon.png');
    Image image = Image(
      image: assetImage,
      height: 250.0,
    );

    return Container(
      child: image,
      padding: EdgeInsets.all(this._minimumPadding * 5),
    );
  }

  void _onDropdownItemSelected(String newValue) {
    setState(() {
      this._currencySelected = newValue;
    });
  }

  String _calculatePayment() {
    double principalInput = double.parse(this.principalController.text);
    double roiInput = double.parse(this.roiController.text);
    double termInput = double.parse(this.termController.text);

    double paymentTotal =
        principalInput + (principalInput * roiInput * termInput) / 100;

    String paymentInfo =
        "After $termInput years, your investment will be worth $paymentTotal $_currencySelected";
    return paymentInfo;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";

    setState(() {
      displayResult = "";
      _currencySelected = this._currencies[0];
    });
  }
}
