// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderAdminDrawer with ChangeNotifier {
  bool _ajout_voyage = true;
  bool _ajout_bus = false;
  bool _list_voyage = false;
  bool _list_bus = false;
  bool _list_tickets = false;
  bool _list_users = false;

  bool get ajout_voyage {
    return _ajout_voyage;
  }

  bool get ajout_bus {
    return _ajout_bus;
  }

  bool get list_voyage {
    return _list_voyage;
  }

  bool get list_bus {
    return _list_bus;
  }

  bool get list_tickets {
    return _list_tickets;
  }

  bool get list_users {
    return _list_users;
  }

  void ajouter_voyage() {
    _ajout_voyage = true;
    _ajout_bus = false;
    _list_bus = false;
    _list_voyage = false;
    _list_tickets = false;
    _list_users = false;
    notifyListeners();
  }

  void ajouter_bus() {
    _ajout_voyage = false;
    _ajout_bus = true;
    _list_bus = false;
    _list_voyage = false;
    _list_tickets = false;
    _list_users = false;
    notifyListeners();
  }

  void liste_voyage() {
    _ajout_voyage = false;
    _ajout_bus = false;
    _list_bus = false;
    _list_voyage = true;
    _list_tickets = false;
    _list_users = false;
    notifyListeners();
  }

  void liste_bus() {
    _ajout_voyage = false;
    _ajout_bus = false;
    _list_bus = true;
    _list_voyage = false;
    _list_tickets = false;
    _list_users = false;
    notifyListeners();
  }

  void liste_tickets() {
    _ajout_voyage = false;
    _ajout_bus = false;
    _list_bus = false;
    _list_voyage = false;
    _list_tickets = true;
    _list_users = false;
    notifyListeners();
  }

  void liste_users() {
    _ajout_voyage = false;
    _ajout_bus = false;
    _list_bus = false;
    _list_voyage = false;
    _list_tickets = false;
    _list_users = true;
    notifyListeners();
  }
}
