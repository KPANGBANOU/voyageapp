// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_connexion.dart';
import '../services/registration.dart';
import 'rest_password.dart';
import 'wrapper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool connexion = false;
  bool obscure = false;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProviderConnexion>(context);
    connexion = _provider.connexion;
    obscure = _provider.is_obscure;
    password = _provider.password;
    email = _provider.email;
    final _auth = Provider.of<firebaseAuth>(context);
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
          backgroundColor: Colors.white,
          leading: Image.asset(
            "images/logo.jpeg",
            height: 90,
            width: 90,
            scale: 4.5,
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Login",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            // ignore: prefer_const_literals_to_create_immutables
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
                  "Login in user account ",
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
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Adresse E-Mail ** ",
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
                    autocorrect: true,
                    enableSuggestions: true,
                    onChanged: (value) {
                      _provider.change_email(value);
                    },
                    onTap: () {
                      _speak("Votre adresse mail");
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: email.isEmpty ||
                                    email.length < 7 ||
                                    !email.contains("@")
                                ? BorderSide(color: Colors.redAccent)
                                : BorderSide(color: Colors.blue)),
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black)),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Mot de passe",
                    textAlign: TextAlign.justify,
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
                  autocorrect: true,
                  enableSuggestions: true,
                  obscuringCharacter: "*",
                  onChanged: (value) {
                    _provider.change_password(value);
                  },
                  onTap: () {
                    _speak("Votre mot de passe");
                  },
                  obscureText: !obscure,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: password.isEmpty || password.length < 8
                            ? BorderSide(color: Colors.redAccent)
                            : BorderSide(color: Colors.blue)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _provider.obscure_true();
                      },
                      child: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade800),
                    onPressed: () async {
                      try {
                        _provider.connexion_true();
                        if (password.isEmpty ||
                            password.length < 8 ||
                            email.isEmpty ||
                            !email.contains("@")) {
                          _speak("Saisissez bien les champs");
                          _provider.connexion_false();

                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tous les champs sont obligatoires. Veuillez vérifier si vous avez bien renseigné tous ces champs svp !",
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
                          final result = await _auth.signInWithEmailAndPassword(
                              email.trim(), password.trim());

                          if (result != null) {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .update({
                              "mdp": sha1
                                  .convert(utf8.encode(password.trim()))
                                  .toString()
                            });
                            _provider.connexion_false();
                            _speak(
                                "Vous avez été connecté. Veuillez patienter s'il vous plait pour la redirection. Merci");

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Wrapper())));
                          } else {
                            _provider.connexion_false();
                            _speak(
                                "L'adresse mail ou le mot de passe saisi est incorrecte. Si vous avez oublié votre mot de passe , cliquez sur mot de passe oublié afin de le réinitialiser");

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "E-Mai ou mot de passe incorrect. Veuillez réessayez svp !",
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
                        }
                      } catch (e) {
                        _provider.connexion_false();
                        /* _speak(
                                "Une erreur s'est produite. Vérifiez votre connexion internet et réessayez s'il vous plait");*/
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
                    child: connexion
                        ? CircularProgressIndicator(color: Colors.cyan)
                        : Text(
                            "Connexion".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 3)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      "Mot de passe oublié ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "N'avez-vous pas encore un compte actif ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 47,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Créez un compte".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.brown.shade800,
                            fontWeight: FontWeight.bold),
                      ))),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _speak(String text) async {
    final FlutterTts _flutter_tts = FlutterTts();
    _flutter_tts.setLanguage("Fr");
    _flutter_tts.setSpeechRate(0.5);
    _flutter_tts.setVolume(0.5);
    _flutter_tts.setPitch(1.0);
    _flutter_tts.speak(text);
  }
}
