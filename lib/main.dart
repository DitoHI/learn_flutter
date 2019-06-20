import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    title: "",
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  List<String> _currencies = ["rupees", "dollars", "pounds"];
  String _currencySelected;
  final double _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    this._currencySelected = this._currencies[0];
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Principal",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Rate Interest",
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Terms",
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
                    onChanged: (String onValueChanged) {},
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
                        child: Text("Calculate"), onPressed: () {}),
                  ),
                  Expanded(
                    child: RaisedButton(
                        child: Text("Reset"), onPressed: () {}),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(this._minimumPadding * 2),
              child: Text("ToDo Text"),
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
}
