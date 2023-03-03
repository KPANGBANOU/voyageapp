// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_field, prefer_final_fields, prefer_const_constructors_in_immutables, unused_local_variable, unused_element, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_ajout_voyage.dart';
import 'package:interrogation/interface/drawer_damin.dart';
import 'package:interrogation/modals/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AjouterVoyage extends StatefulWidget {
  AjouterVoyage({super.key});

  @override
  State<AjouterVoyage> createState() => _AjouterVoyageState();
}

class _AjouterVoyageState extends State<AjouterVoyage> {
  bool affiche = false;

  String depart = "";

  String destination = "";

  String duree_maximale = "";

  int _dure_maximale = 0;

  String montant = "";

  int _montant_voyage = 0;

  String nombre_place = "";

  int _nombre_place = 0;

  TextEditingController leu_depart = TextEditingController();
  TextEditingController lieu_destinatio = TextEditingController();
  TextEditingController duree_yoyage = TextEditingController();
  TextEditingController montant__voyage = TextEditingController();
  TextEditingController heure_depart = TextEditingController();
  TextEditingController nombre_place_voyage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAjoutVoyage>(context);
    affiche = provider.affiche;
    depart = provider.depart;
    destination = provider.destination;
    duree_maximale = provider.duree_maximale;
    montant = provider.montant;
    nombre_place = provider.nombre_place;
    _dure_maximale = duree_maximale.isNotEmpty ? int.parse(duree_maximale) : 0;
    _nombre_place = nombre_place.isNotEmpty ? int.parse(nombre_place) : 0;
    _montant_voyage = montant.isNotEmpty ? int.parse(montant) : 0;
    Future<bool> ShowExitApp() async {
      return await showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: Text(
                    "Quitter l'application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  content: Text(
                    "Voulez vous vraiment quitter ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade900),
                            onPressed: (() {
                              Navigator.of(context).pop(true);
                            }),
                            child: Text(
                              "Confirmer",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: (() {
                              Navigator.of(context).pop(false);
                            }),
                            child: Text(
                              "Annuler",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              })) ??
          false;
    }

    final user = Provider.of<donnesUtilisateur>(context);

    return Scaffold(
      drawer: DrawerAdmin(),
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Nouvel voyage",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
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
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Voyagez avec nous ",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              color: Colors.white,
              height: 2,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Heure de départ ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedTime != null) {
                      DateTime? parsedTime = DateFormat.Hm()
                          .parse(pickedTime.format(context).toString());
                      String formatTime =
                          DateFormat('HH:mm').format(parsedTime);
                      heure_depart.text = formatTime;
                    } else {
                      heure_depart.text = "";
                    }
                  },
                  controller: heure_depart,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) {
                    provider.change_depart(value, leu_depart);
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Lieu de départ ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  controller: leu_depart,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) {
                    provider.change_depart(value, leu_depart);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: depart.isEmpty
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Lieu de destination ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  controller: lieu_destinatio,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) {
                    provider.change_destination(value, lieu_destinatio);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: destination.isEmpty
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Nombre de place pour le voyage ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: nombre_place_voyage,
                  onChanged: (value) {
                    provider.change_nombre_place(value);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: nombre_place.isEmpty
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Durée maximale du voyage en heures ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  controller: duree_yoyage,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    provider.change_duree_maximale(value);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: duree_maximale.isEmpty
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Montant du voyage ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: montant__voyage,
                  onChanged: (value) {
                    provider.change_montant(value);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: montant.isEmpty
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.91,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () async {
                    try {
                      provider.affiche_true();
                      if (leu_depart.text.isEmpty ||
                          lieu_destinatio.text.isEmpty ||
                          heure_depart.text.isEmpty ||
                          nombre_place_voyage.text.isEmpty ||
                          _nombre_place <= 0 ||
                          montant__voyage.text.isEmpty ||
                          _montant_voyage <= 0 ||
                          duree_yoyage.text.isEmpty ||
                          _dure_maximale <= 0) {
                        provider.affiche_false();
                        _speak("Vous devez bien saisir tous les champs");
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Vous devez bien saisir tous les champs!",
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
                      } else {
                        final result = await FirebaseFirestore.instance
                            .collection("voyages")
                            .where("nom",
                                isEqualTo:
                                    "VOYAGE " + depart + "-" + destination)
                            .get();
                        final is_empty = result.docs.isEmpty;
                        if (!is_empty) {
                          provider.affiche_false();
                          _speak(
                              "Ce type voyage existe déjà dans notre base de données");
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Ce type de voyage existe déjà dans notre base de données",
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
                        } else {
                          await FirebaseFirestore.instance
                              .collection("voyages")
                              .add({
                            "user_uid": user.uid,
                            "nom": "VOYAGE " + depart + "-" + destination,
                            "created_at": DateTime.now(),
                            "updated_at": DateTime.now(),
                            "nombre_place": _nombre_place,
                            "nombre_restant": _nombre_place,
                            "montant": _montant_voyage,
                            "duree_voyage": _dure_maximale,
                            "heure_depart": heure_depart.text,
                            "lieu_depart": depart,
                            "lieu_destination": destination,
                            "photo": "",
                          });
                          provider.affiche_false();
                          _speak("Enregistré avec succès");
                          leu_depart.clear();
                          lieu_destinatio.clear();
                          montant__voyage.clear();
                          nombre_place_voyage.clear();
                          heure_depart.clear();
                          duree_yoyage.clear();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Succesfully savez in data base",
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
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        }
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
                          color: Colors.black87,
                        )
                      : Text(
                          "Enregister".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alike(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        )),
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
