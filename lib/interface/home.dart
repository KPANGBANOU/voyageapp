// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/interface/drawer.dart';
import 'package:interrogation/modals/user.dart';
import 'package:provider/provider.dart';

import '../modals/voyage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
    final list_voyage = Provider.of<List<Voyages>>(context);

    if (list_voyage.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Image.asset(
              "images/icon.png",
              height: 90,
              width: 90,
              scale: 4.5,
            ),
            elevation: 0,
            centerTitle: true,
            title: Text(
              user.prenom,
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

    return WillPopScope(
      onWillPop: ShowExitApp,
      child: Scaffold(
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
            ],
          ),
        ),
      ),
    );
  }
}
