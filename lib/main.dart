// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables, must_be_immutable, unused_local_variable, non_constant_identifier_names, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, deprecated_member_use, unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interrogation/Provider/provider_admin_drawer.dart';
import 'package:interrogation/Provider/provider_ajout_voyage.dart';
import 'package:interrogation/Provider/provider_connexion.dart';
import 'package:interrogation/Provider/provider_crer_compte.dart';
import 'package:interrogation/Provider/provider_demander_ticket.dart';
import 'package:interrogation/Provider/provider_search.dart';
import 'package:interrogation/Provider/reste_password.dart';
import 'package:interrogation/modals/user.dart';
import 'package:interrogation/services/base_de_donne.dart';
import 'package:interrogation/services/registration.dart';
import 'package:provider/provider.dart';

import 'interface/my_splas.dart';
import 'modals/voyage.dart';

// ignore: import_of_legacy_library_into_null_safe

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({key}) : super(key: key);
  String uid = "";

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return MultiProvider(
      providers: [
        Provider<firebaseAuth>(create: (_) => firebaseAuth()),
        Provider<ServiceDB>(create: (_) => ServiceDB()),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().currentuserdata,
            initialData: donnesUtilisateur(
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                role: "",
                sexe: "",
                date_naissance: "",
                uid: uid,
                photo_url: "",
                admin: false,
                is_active: true,
                mdp: "",
                date_inscription: "",
                deleted: false)),
        StreamProvider(
            create: (context) => context.read<firebaseAuth>().utilisateur,
            initialData: null),
        StreamProvider(
          create: (context) => context.read<ServiceDB>().list_voyages,
          initialData: <Voyages>[],
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderConnexion(),
        ),
        ChangeNotifierProvider(
          create: (context) => providerCreateAccount(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderResetPassword(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAdminDrawer(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAjoutVoyage(),
        ),
        ChangeNotifierProvider(create: (context) => Search()),
        ChangeNotifierProvider(create: (context) => ProviderDemanderTicket()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
