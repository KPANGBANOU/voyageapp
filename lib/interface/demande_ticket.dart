// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_demander_ticket.dart';
import 'package:interrogation/interface/drawer.dart';
import 'package:interrogation/interface/random.dart';
import 'package:interrogation/modals/user.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../modals/voyage.dart';

class DemanderTicket extends StatefulWidget {
  DemanderTicket({super.key});

  @override
  State<DemanderTicket> createState() => _DemanderTicketState();
}

class _DemanderTicketState extends State<DemanderTicket> {
  @override
  Widget build(BuildContext context) {
    bool affiche = false;
    final provider = Provider.of<ProviderDemanderTicket>(context);
    affiche = provider.affiche;
    Timestamp time = Timestamp.now();
    String day = DateFormat("dd-MM-yyyy").format(time.toDate());
    String heure = DateFormat("HH/mm:ss").format(time.toDate());
    final user = Provider.of<donnesUtilisateur>(context);
    final voyage = Provider.of<Voyages>(context);
    final _pdf = pw.Document();

    return Scaffold(
      drawer: DrawerUser(),
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        centerTitle: true,
        title: Text(
          user.prenom,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          Image.asset(
            "images/bus1.jfif",
            scale: 4.5,
            height: 90,
            width: 90,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/icon3.jpeg"),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Voyagez avec nous",
              textAlign: TextAlign.center,
              style: GoogleFonts.alike(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 2,
                  width: 40,
                  color: Colors.white,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  height: 15,
                  width: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 2,
                  width: 40,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.94,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue.shade900),
                        onPressed: () {},
                        child: Text(
                          "Informations sur le voyage".toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alike(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Voyage",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.nom,
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Départ",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.lieu_depart,
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lieu destination",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.lieu_destination,
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Heure départ",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.heure_depart,
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Duréé maximale du voyage",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.duree_voyage.toString() + "  Heures",
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Montant du voyage",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.montant.toString() + " XOF",
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nombre de siége ",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.nombre_place.toString(),
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sièges déjà occupés",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            (voyage.nombre_place - voyage.nombre_restant)
                                .toString(),
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nombre de siéges restant",
                          style: GoogleFonts.alike(
                              color: Colors.lightBlue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            voyage.nombre_restant.toString(),
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87),
                        onPressed: () async {
                          try {
                            provider.affiche_true();
                            if (voyage.nombre_restant <= 0) {
                              provider.affiche_false();
                              _speak(
                                  "Il n'y a plus de place pour ce voyage. Nous sommes désolé cher client");
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Il n'y a plus  de place pour ce voyage",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                backgroundColor:
                                    Colors.redAccent.withOpacity(.8),
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            } else {
                              var random = Random();

                              var identifiant = random.nextInt(32);

                              await FirebaseFirestore.instance
                                  .collection("tickets")
                                  .add({
                                "identifiant": identifiant,
                                "user_uid": user.uid,
                                "voyage_uid": voyage.uid,
                                "destination": voyage.lieu_destination,
                                "created_at": DateTime.now(),
                                "siege_occupe": voyage.nombre_restant
                              });
                              await FirebaseFirestore.instance
                                  .collection("voyages")
                                  .doc(voyage.uid)
                                  .update({
                                "nombre_restant": voyage.nombre_restant - 1
                              });

                              final pdf = pw.Document();
                              pdf.addPage(pw.MultiPage(
                                  pageFormat: PdfPageFormat.a4,
                                  build: ((pw.Context context) {
                                    return [
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(day + " " + heure),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                          "Ticket de voyage de  "
                                                  .toUpperCase() +
                                              user.prenom +
                                              " " +
                                              user.nom,
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 20,
                                              color: PdfColors.black)),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Compaginre: "
                                                        .toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text("VOYAGE APP",
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Numero tickety: "
                                                        .toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(identifiant.toString(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Client: ".toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(
                                                    user.prenom +
                                                        " " +
                                                        user.nom,
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Téléphone: ".toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(user.telephone,
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Montant: ".toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(
                                                    voyage.montant.toString() +
                                                        " XOF",
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Départ: ".toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(voyage.lieu_depart,
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Heure départ: "
                                                        .toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(voyage.heure_depart,
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Destination: "
                                                        .toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(voyage.lieu_destination,
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            pw.FontWeight.bold))
                                              ])),
                                      pw.SizedBox(height: 10),
                                      pw.SizedBox(height: 20),
                                      pw.Container(
                                          width: double.infinity,
                                          height: 40,
                                          child: pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Text(
                                                    "Merci pour la confiance "
                                                        .toUpperCase(),
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ])),
                                    ];
                                  })));

                              final path =
                                  (await getExternalStorageDirectory())!.path;

                              final _file1 = File('$path/ticket.pdf');
                              await _file1.writeAsBytes(
                                await pdf.save(),
                              );

                              String username = 'agripiyalo@gmail.com';
                              String password = 'ghcaxojthaqzmhdc';

                              final smtpServer = gmail(username, password);

                              final message = Message()
                                ..from = Address(username, 'Voyage App')
                                ..recipients.add(user.email.trim())
                                ..ccRecipients
                                //.addAll(['destCc1@example.com', 'destCc2@example.com'])
                                //..bccRecipients.add(Address('bccAddress@example.com'))
                                ..subject = "Confirmation de voyage"
                                ..text = "Mr/Mme  " +
                                    user.prenom +
                                    " " +
                                    user.nom +
                                    "Votre démande de ticket de réservation de place a été bien recue. Vous occuper le siège " +
                                    (voyage.nombre_restant).toString() +
                                    "\n Vous pouvez utiliser le numero du ticket pour annuler le voyage en cas d'empevhement\n" +
                                    "\nMerci pour la confiance"
                                ..attachments = [
                                  FileAttachment(_file1)
                                    ..location = Location.inline
                                    ..cid = 'ticket.pdf'
                                ];

                              final sendReport =
                                  await send(message, smtpServer);

                              _speak(
                                  "Ticket généré. Un message de confirmation a été envoyé via votre mail");
                              provider.affiche_false();

                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ticket généré avec succès. Message de confirmation envoyé à l'adresse e-mail " +
                                        user.email,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                backgroundColor: Colors.black87,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            }
                          } catch (e) {
                            provider.affiche_false();
                            _speak(
                                "Une erreur s'est produite. Vérifiez votre connexion internet et réessayez s'il vous plait");
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Une erreur inattendue s'est produite. Vérifiez votre connexion internet et réessayez svp!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          }
                        },
                        child: affiche
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Démandez le ticket".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.alike(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

Future _speak(String text) async {
  final FlutterTts _flutter_tts = FlutterTts();
  _flutter_tts.setLanguage("Fr");
  _flutter_tts.setSpeechRate(0.5);
  _flutter_tts.setVolume(0.5);
  _flutter_tts.setPitch(1.0);
  _flutter_tts.speak(text);
}
