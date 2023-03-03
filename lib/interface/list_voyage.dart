// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_search.dart';
import 'package:interrogation/interface/drawer.dart';
import 'package:provider/provider.dart';

import '../modals/voyage.dart';
import 'stream_du_voyage.dart';

class ListeVoyage extends StatefulWidget {
  ListeVoyage({super.key});

  @override
  State<ListeVoyage> createState() => _ListeVoyageState();
}

class _ListeVoyageState extends State<ListeVoyage> {
  bool affiche = false;

  String value = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Search>(context);
    affiche = provider.affiche;
    value = provider.value;

    final list_voyage = Provider.of<List<Voyages>>(context);

    if (list_voyage.isEmpty) {
      return Scaffold(
          drawer: DrawerUser(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Voyages",
              style: GoogleFonts.alike(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
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
          body: Center(
            child: CircularProgressIndicator(color: Colors.black87),
          ));
    }

    return Scaffold(
        drawer: DrawerUser(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: affiche
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      provider.change_value(value);
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: "Recherchez ...",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                )
              : Text(
                  "Voyages",
                  style: GoogleFonts.alike(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
          actions: [
            IconButton(
                onPressed: (() {
                  provider.afficher();
                }),
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                  size: 20,
                )),
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Voyages voyage = list_voyage[index];
              return !affiche
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StreamDuVoyage(
                                voyage_uid: voyage.uid,
                                user_uid: voyage.user_uid,
                              ),
                            ));
                      },
                      title: Text(
                        voyage.nom,
                        style: GoogleFonts.alice(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Départ : " +
                            voyage.lieu_depart +
                            " à " +
                            voyage.heure_depart,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue.shade900,
                        child: Text(
                          voyage.lieu_depart.substring(0, 1) +
                              voyage.lieu_destination.substring(0, 1),
                          style: GoogleFonts.alike(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            SupprimerVoyage(context, voyage.nom, voyage.uid);
                          },
                          icon: Icon(Icons.delete)),
                    )
                  : voyage.nom.toLowerCase().contains(value.toLowerCase())
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StreamDuVoyage(
                                    voyage_uid: voyage.uid,
                                    user_uid: voyage.uid,
                                  ),
                                ));
                          },
                          trailing: IconButton(
                              onPressed: () {
                                SupprimerVoyage(
                                    context, voyage.nom, voyage.uid);
                              },
                              icon: Icon(Icons.delete)),
                          title: Text(
                            voyage.nom,
                            style: GoogleFonts.alice(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "Départ : " +
                                voyage.lieu_depart +
                                " à " +
                                voyage.heure_depart,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.lightBlue.shade900,
                            child: Text(
                              voyage.lieu_depart.substring(0, 1) +
                                  voyage.lieu_destination.substring(0, 1),
                              style: GoogleFonts.alike(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container();
            },
            itemCount: list_voyage.length,
          ),
        ));
  }

  Future<void> SupprimerVoyage(
      BuildContext context, String voyage_nom, String voyage_uid) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Etes vous sur ?".toUpperCase()),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Voudriez vous supprimer le " +
                      voyage_nom.toLowerCase() +
                      " ?"),
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            textStyle: TextStyle()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Confirmer'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance
                                .collection("voyages")
                                .doc(voyage_uid)
                                .delete();
                            _speak("Ce voyage a été supprimé avec succès");
                            Navigator.of(context).pop();

                            // ignore: empty_catches
                          } catch (e) {
                            _speak("Une erreur inattendue s'est produite");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(.7),
                            textStyle: TextStyle()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Annuler'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () {
                          _speak("Suppresion du voyage annulée");
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          );
        });
  }
}

Future _speak(String text) async {
  final FlutterTts flutter_tts = FlutterTts();
  flutter_tts.setLanguage("Fr");
  flutter_tts.setSpeechRate(0.5);
  flutter_tts.setVolume(0.5);
  flutter_tts.setPitch(1.0);
  flutter_tts.speak(text);
}
