import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'package:learnv2/weather_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Provider Demo",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => WeatherInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Provider Pattern"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MySpecialHeading(),
              MySpecialContent(),
            ],
          ),
        ),
        floatingActionButton: MyFlotingActionButton(),
      ),
    );
  }
}

class MySpecialHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherInfo>(
      builder: (context, weatherInfo, _) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              weatherInfo.temperatureType,
              style: TextStyle(color: _decideColor(weatherInfo), fontSize: 25.0),
            ),
          ),
    );
  }
}

class MySpecialContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text("Temperature Value"));
  }
}

class MyFlotingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context);

    return FloatingActionButton(
      backgroundColor: _decideColor(weatherInfo),
      onPressed: () {
        String weatherType = weatherInfo.temperatureType == "celcius" ? "far" : "celcius";
        weatherInfo.temperatureType = weatherType;
      },
      tooltip: 'Change Type',
      child: Icon(Icons.chat),
    );
  }
}

Color _decideColor(WeatherInfo info) {
  return info.temperatureType == "celcius" ? Colors.green : Colors.deepOrange;
}
