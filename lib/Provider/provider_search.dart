// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Search with ChangeNotifier {
  bool _affiche = false;
  String _value = "";

  String get value {
    return _value;
  }

  bool get affiche {
    return _affiche;
  }

  void afficher() {
    _affiche = !_affiche;
    notifyListeners();
  }

  void change_value(String? value) {
    _value = value!;
    notifyListeners();
  }
}
