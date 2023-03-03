// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:interrogation/interface/demande_ticket.dart';
import 'package:interrogation/modals/voyage.dart';
import 'package:interrogation/services/base_de_donne.dart';
import 'package:provider/provider.dart';

class StreamVoyage extends StatelessWidget {
  const StreamVoyage({super.key, required this.voyage_uid});
  final String voyage_uid;
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
                photo: ""))
      ],
      child: DemanderTicket(),
    );
  }
}
