// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderDemanderTicket with ChangeNotifier {
  bool _affiche = false;
  String _lieu = "";
  bool get affiche {
    return _affiche;
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  String get lieu {
    return _lieu;
  }

  void change_lieu(String? value, TextEditingController lieu) {
    _lieu = value!;
    lieu.value =
        TextEditingValue(text: value.toUpperCase(), selection: lieu.selection);
    notifyListeners();
  }
}
