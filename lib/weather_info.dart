import 'package:flutter/foundation.dart';

class WeatherInfo with ChangeNotifier {

  String _tempType = "celcius";
  int _tempValue = 25;

  int get temperatureVal => _tempValue;

  String get temperatureType => _tempType;

  set temperatureValue(int tempVal) {
    this._tempValue = tempVal;
    notifyListeners();
  }

  set temperatureType(String tempType) {
    this._tempType = tempType;
    notifyListeners();
  }
}