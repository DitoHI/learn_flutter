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
}
