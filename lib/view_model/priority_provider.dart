import 'package:flutter/material.dart';

class PriorityProvider with ChangeNotifier {
  List<String> items = ['High', 'Medium', 'Low'];
  String _dropdownValue = 'High';
  String get dropdownValue => _dropdownValue;

  setDropDownValue(String val) {
    _dropdownValue = val;
    notifyListeners();
  }
}
