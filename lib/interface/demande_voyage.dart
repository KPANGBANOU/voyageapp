// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_search.dart';
import 'package:interrogation/interface/drawer.dart';
import 'package:interrogation/interface/stream_voyage.dart';
import 'package:provider/provider.dart';

import '../modals/voyage.dart';

class DemanderVoyage extends StatefulWidget {
  DemanderVoyage({super.key});

  @override
  State<DemanderVoyage> createState() => _DemanderVoyageState();
}

class _DemanderVoyageState extends State<DemanderVoyage> {
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
              style: TextStyle(
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
                  style: TextStyle(
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
                              builder: (context) =>
                                  StreamVoyage(voyage_uid: voyage.uid),
                            ));
                      },
                      title: Text(
                        voyage.nom,
                        style: GoogleFonts.alice(
                            color: Colors.black87, fontWeight: FontWeight.bold),
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
                    )
                  : voyage.nom.toLowerCase().contains(value.toLowerCase())
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StreamVoyage(voyage_uid: voyage.uid),
                                ));
                          },
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
}
