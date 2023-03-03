// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/interface/connexion.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_crer_compte.dart';
import '../services/registration.dart';
import 'wrapper.dart';

class ValidateUserEmail extends StatefulWidget {
  ValidateUserEmail(
      {super.key,
      required this.email,
      required this.user_nom,
      required this.user_prenom,
      required this.user_telephone,
      required this.user_date_naissance,
      required this.sexe,
      required this.user_password,
      required this.code});
  final String email;
  final String user_nom;
  final String user_prenom;
  final String user_telephone;
  final String user_date_naissance;
  final String sexe;
  final String user_password;
  final int code;

  @override
  State<ValidateUserEmail> createState() => _ValidateUserEmailState();
}

class _ValidateUserEmailState extends State<ValidateUserEmail> {
  bool affice = false;

  int _code = 0;

  TextEditingController _code_saisi = TextEditingController();

  int leng = 0;

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<firebaseAuth>(context);
    final _affiche = Provider.of<providerCreateAccount>(context);
    affice = _affiche.circular;
    _code = _affiche.code;
    leng = widget.email.length;
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

    return WillPopScope(
      onWillPop: ShowExitApp,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade900,
        appBar: AppBar(
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
          leading: Image.asset(
            "images/icon.png",
            height: 90,
            width: 90,
            scale: 4.5,
          ),
          centerTitle: true,

          backgroundColor: Colors.white,
          title: Text(
            "Validate email",
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // centerTitle: true,
          elevation: 0,
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
                  "Validate user email ",
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
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  "Un code a été envoyé à l'email " +
                      widget.email.substring(0, 3) +
                      "*************" +
                      widget.email.substring(leng - 8, leng) +
                      "\n Veuillez saisir ce code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez le code",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 2),
                child: TextField(
                  controller: _code_saisi,
                  onChanged: (value) {
                    _affiche.change_code(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black),
                    counterText: "",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87),
                      onPressed: (() async {
                        _affiche.circular_true();

                        try {
                          if (_code_saisi.text.isEmpty ||
                              _code_saisi.text.length != 5) {
                            _affiche.circular_false();

                            _speak(
                                "Le code saisi est vide ou incorrecte. Veuillez vérifier et réessayez. Merci");
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Le code saisi est vide ou incoorecte ! !",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          } else if (_code == widget.code) {
                            final _result =
                                await firebase.createUserWithEmailAndPassword(
                                    widget.email, widget.user_password);

                            if (_result != null) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "deleted": false,
                                "nom": widget.user_nom,
                                "prenom": widget.user_prenom,
                                "sexe": widget.sexe,
                                "date_naissance": widget.user_date_naissance,
                                "telephone": widget.user_telephone,
                                "email": widget.email,
                                "timestamp": DateTime.now(),
                                "admin": false,
                                "is_active": false,
                                "photo_url": "",
                                'role': "Employé",
                                "mdp": sha1
                                    .convert(utf8
                                        .encode(widget.user_password.trim()))
                                    .toString(),
                              });

                              _speak("Votre compte a été créé avec succès");
                              _affiche.circular_false();

                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Votre compte a été créé avec succès",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Wrapper())));
                            } else {
                              _speak(
                                  "L'email utilisé existe déjà ou le mot de passe que vous avez utilisé est moins sécurisé. Réessayez s'il vous plait");
                              _affiche.circular_false();
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "L'email utilisé existe dèjà ou le mot de passe utilisé est moins sécurisé. Veuillez réessayez svp !",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginPage())));
                            }
                          } else {
                            _affiche.circular_false();
                            _speak(
                                "Le code saisi est incorrecte. Merci de réessayez");

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Le code saisi incoorecte ! !",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          }
                        } catch (e) {
                          _affiche.circular_false();
                          _speak(
                              "Une erreur s'est produite. Vérifiez votre connection internet et réessayez. Merci");
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  /* "Une erreur s'est produite. Merci de vérifiez votre connection internet et réessayez!"*/ e
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            backgroundColor: Colors.redAccent.withOpacity(.8),
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: affice
                              ? CircularProgressIndicator(
                                  color: Colors.cyanAccent,
                                )
                              : Text(
                                  "Saisissez le code".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
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
