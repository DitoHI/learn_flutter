import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Stateful App Example",
    home: FavoriteCity(),
  ));
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";
  var _currencies = ["rupees", "dollar", "yuan"];
  String __currentSelected = "dollar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              items: _currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                this._onDropdownSelected(newValueSelected);
              },
              value: this.__currentSelected,
            ),
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  this.nameCity = userInput;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "The best city is $nameCity",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDropdownSelected(String valueSelected) {
    setState(() {
      this.__currentSelected = valueSelected;
    });
  }
}
