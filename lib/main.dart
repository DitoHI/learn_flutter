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
  List<String> _currencies = ["rupees", "dollars", "pounds"];
  String _currencySelected;
  final double _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    this._currencySelected = this._currencies[0];

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
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {}),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(this._minimumPadding * 2),
              child: Text(
                "ToDo Text",
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
}
