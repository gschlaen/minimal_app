import 'package:flutter/material.dart';

class SearchBarProvider extends ChangeNotifier {
  int _textLength = 0;

  int get textLength => _textLength;

  set textLength(int value) {
    _textLength = value;
    notifyListeners();
  }
}
