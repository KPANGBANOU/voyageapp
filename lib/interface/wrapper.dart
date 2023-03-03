// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:interrogation/interface/home.dart';
import 'package:interrogation/interface/homed_admin.dart';
import 'package:interrogation/modals/user.dart';
import 'package:provider/provider.dart';

import 'accueil.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utilisateur?>(context);
    final user_data = Provider.of<donnesUtilisateur>(context);
    if (user == null)
      return Accueil();
    else if (user_data.admin) return HomeAdmin();
    return Home();
  }
}
