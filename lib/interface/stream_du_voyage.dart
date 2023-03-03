// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:interrogation/interface/info_voyage.dart';
import 'package:interrogation/modals/user.dart';
import 'package:interrogation/modals/voyage.dart';
import 'package:interrogation/services/base_de_donne.dart';
import 'package:provider/provider.dart';

class StreamDuVoyage extends StatelessWidget {
  const StreamDuVoyage(
      {super.key, required this.voyage_uid, required this.user_uid});
  final String voyage_uid;
  final String user_uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ServiceDB>(create: (_) => ServiceDB()),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().voyage(voyage_uid),
            initialData: Voyages(
                uid: voyage_uid,
                user_uid: "",
                nom: "",
                lieu_depart: "",
                lieu_destination: "",
                heure_depart: "",
                created_at: "",
                nombre_place: 0,
                nombre_restant: 0,
                duree_voyage: 0,
                montant: 0,
                photo: "")),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().user_data(user_uid),
            initialData: donnesUtilisateur(
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                role: "",
                sexe: "",
                date_naissance: "",
                uid: user_uid,
                photo_url: "",
                admin: false,
                is_active: true,
                mdp: "",
                date_inscription: "",
                deleted: false))
      ],
      child: InfoYoyage(),
    );
  }
}
