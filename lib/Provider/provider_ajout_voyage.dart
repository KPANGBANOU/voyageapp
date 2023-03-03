// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderAjoutVoyage with ChangeNotifier {
  bool _affiche = false;
  String _depart = "";
  String _destination = "";
  String _duree_maximale = "";
  String _montant = "";
  String _nombre_place = "";
  String get nombre_place {
    return _nombre_place;
  }

  String get depart {
    return _depart;
  }

  String get destination {
    return _destination;
  }

  String get duree_maximale {
    return _duree_maximale;
  }

  String get montant {
    return _montant;
  }

  bool get affiche {
    return _affiche;
  }

  void change_nombre_place(String? value) {
    _nombre_place = value!;
    notifyListeners();
  }

  void change_duree_maximale(String? value) {
    _duree_maximale = value!;
    notifyListeners();
  }

  void change_depart(String? value, TextEditingController lieu_depart) {
    _depart = value!;
    lieu_depart.value = TextEditingValue(
        text: value.toUpperCase(), selection: lieu_depart.selection);
    notifyListeners();
  }

  void change_destination(
      String? value, TextEditingController lieu_destination) {
    _destination = value!;
    lieu_destination.value = TextEditingValue(
        text: value.toUpperCase(), selection: lieu_destination.selection);
    notifyListeners();
  }

  void change_montant(String? value) {
    _montant = value!;
    notifyListeners();
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }
}
