// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_admin_drawer.dart';
import 'package:interrogation/interface/ajouter_voyage.dart';
import 'package:interrogation/interface/connexion.dart';
import 'package:interrogation/interface/list_voyage.dart';
import 'package:interrogation/modals/user.dart';
import 'package:provider/provider.dart';

class DrawerAdmin extends StatefulWidget {
  DrawerAdmin({super.key});

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  bool ajout_voyage = true;
  bool ajout_bus = false;
  bool list_voyage = false;
  bool list_bus = false;
  bool list_tickets = false;
  bool list_users = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<donnesUtilisateur>(context);
    final provider = Provider.of<ProviderAdminDrawer>(context);
    ajout_bus = provider.ajout_bus;
    ajout_voyage = provider.ajout_voyage;
    list_voyage = provider.list_voyage;
    list_bus = provider.list_bus;
    list_tickets = provider.list_tickets;
    list_users = provider.list_users;
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Image.asset(
                  "images/icon.png",
                  scale: 4.5,
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  user.prenom + " " + user.nom,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            )),
            ListTile(
              onTap: () {
                provider.ajouter_voyage();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AjouterVoyage(),
                    ));
              },
              tileColor: ajout_voyage ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Ajouter un voyage",
                style: GoogleFonts.alike(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                provider.liste_voyage();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListeVoyage(),
                    ));
              },
              tileColor: list_voyage ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Liste des voyages",
                style: GoogleFonts.alike(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                provider.liste_tickets();
              },
              tileColor: list_tickets ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Liste des tickets tickets",
                style: GoogleFonts.alike(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                provider.liste_users();
              },
              tileColor: list_users ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Liste des utilisateurs",
                style: GoogleFonts.alike(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () async {
                _LogOut(context);
              },
              title: Text(
                "Déconnexion",
                style: GoogleFonts.alike(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _LogOut(
  BuildContext context,
) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Etes vous sur ?".toUpperCase()),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text("Voudriez vous déconnecter ?"),
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
                          await FirebaseAuth.instance.signOut();
                          _speak("Vous avez été déconnecté");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => LoginPage())));

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
                        _speak("Deconnexion annulée");
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

Future _speak(String text) async {
  final FlutterTts flutter_tts = FlutterTts();
  flutter_tts.setLanguage("Fr");
  flutter_tts.setSpeechRate(0.5);
  flutter_tts.setVolume(0.5);
  flutter_tts.setPitch(1.0);
  flutter_tts.speak(text);
}
