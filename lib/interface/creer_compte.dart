// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_string_interpolations, unused_field, use_build_context_synchronously, unused_local_variable, depend_on_referenced_packages, non_constant_identifier_names, must_be_immutable, empty_catches, unred_type_equality_checks, unnecessary_null_comparison, prefer_final_fields, unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/Provider/provider_crer_compte.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

import 'connexion.dart';
import 'random.dart';
import 'validate_user_email.dart';

class RegisterPage extends StatelessWidget {
  //To Toggle Password Text Visibility.

  //For the loading state.

  TextEditingController _date = TextEditingController();
  TextEditingController nom_user = TextEditingController();
  TextEditingController prenom_user = TextEditingController();
  TextEditingController email_user = TextEditingController();
  TextEditingController numero_user = TextEditingController();
  TextEditingController password_user = TextEditingController();
  TextEditingController confirm_password_user = TextEditingController();
  bool affiche = false;
  String sexe = "Maculin";
  String nom = "";
  String prenom = "";
  String email = "";
  String numero = "";
  String password = "";
  String confirm_password = "";
  bool obscure_password = false;
  int _code = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<providerCreateAccount>(context);
    sexe = provider.sexe;
    nom = provider.nom;
    prenom = provider.prenom;
    email = provider.email;
    numero = provider.numero;
    password = provider.password;
    confirm_password = provider.confirm_password;
    obscure_password = provider.password_obscure;
    affiche = provider.affiche;
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
            "images/logo.jpeg",
            height: 90,
            width: 90,
            scale: 4.5,
          ),

          backgroundColor: Colors.white,
          title: Text(
            "Creat account",
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
                  "Creat user account ",
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
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre nom",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: nom_user,
                  onChanged: (value) {
                    provider.change_nom(value, nom_user);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: nom.isEmpty || nom.length < 3
                                  ? Colors.red
                                  : Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre prénom",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (value) {
                    provider.change_prenom(value, prenom_user);
                  },
                  controller: prenom_user,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: prenom.isEmpty || prenom.length < 3
                                  ? Colors.red
                                  : Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Votre adresse E-Mail",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (value) {
                    provider.change_email(value);
                  },
                  controller: email_user,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: email.isEmpty || !email.contains("@")
                                  ? Colors.red
                                  : Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre numéro",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: numero_user,
                  onChanged: (value) {
                    provider.change_numero(value);
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: numero.length < 8
                                  ? Colors.red
                                  : Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      labelStyle: GoogleFonts.lato(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Votre sexe",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              RadioListTile(
                title: Text(
                  "Masculin".toUpperCase(),
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                value: "Masculin",
                groupValue: sexe,
                onChanged: (value) {
                  provider.change_sexe(value);
                },
              ),
              RadioListTile(
                title: Text(
                  "Féminin".toUpperCase(),
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                value: "Féminin",
                groupValue: sexe,
                onChanged: (value) {
                  provider.change_sexe(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Votre date de naissance",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _date,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      labelStyle: GoogleFonts.lato(color: Colors.white)),
                  readOnly: true,
                  onTap: () async {
                    var dateSelectionned = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (dateSelectionned != null) {
                      String formatDate =
                          DateFormat('dd-MM-yyyy').format(dateSelectionned);
                      _date.text = formatDate;

                      _date.text = formatDate;
                      // ignore: curly_braces_in_flow_control_structures
                    } else {
                      _date.text = "";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre mot de passe",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: obscure_password,
                  controller: password_user,
                  onChanged: (value) {
                    provider.change_password(value);
                  },
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: password.isEmpty || password.length < 8
                                  ? Colors.red
                                  : Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      suffixIcon: IconButton(
                          onPressed: () {
                            provider.change_password_obscure();
                          },
                          icon: obscure_password
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirmez votre mot de passe",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: confirm_password_user,
                  onChanged: (value) {
                    provider.change_confirm_password(value);
                  },
                  obscuringCharacter: "*",
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: confirm_password.isEmpty ||
                                    confirm_password.length < 8 ||
                                    confirm_password != password
                                ? Colors.red
                                : Colors.blue)),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.lato(color: Colors.black),
                    labelStyle: GoogleFonts.lato(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900,
                      ),
                      // ignore: sort_child_properties_last
                      child: affiche
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Création du compte".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                      onPressed: () async {
                        try {
                          if (nom.isEmpty ||
                              nom.length < 3 ||
                              prenom.isEmpty ||
                              prenom.length < 3 ||
                              email.isEmpty ||
                              email.length < 7 ||
                              !email.contains('@') ||
                              numero.isEmpty ||
                              numero.length != 8 ||
                              sexe.isEmpty ||
                              password.length < 8 ||
                              confirm_password != password) {
                            provider.affiche_false();
                            _speak(
                                "Renseignez bien toutes les informations s'il vous plait");
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Certaines informations sont mal renseignées !",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
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
                            _code = RandomDigits.getInteger(5);

                            String username = 'agripiyalo@gmail.com';
                            String password = 'ghcaxojthaqzmhdc';

                            final smtpServer = gmail(username, password);
                            // Use the SmtpServer class to configure an SMTP server:
                            // final smtpServer = SmtpServer('smtp.domain.com');
                            // See the named arguments of SmtpServer for further configuration
                            // options.

                            // Create our message.
                            final message = Message()
                              ..from = Address(username, 'Voyage App')
                              ..recipients.add(email.trim())
                              ..ccRecipients
                              //.addAll(['destCc1@example.com', 'destCc2@example.com'])
                              //..bccRecipients.add(Address('bccAddress@example.com'))
                              ..subject = "Validation de l'adresse e-mail"
                              // ignore: prefer_interpolation_to_compose_strings
                              ..text = " " +
                                  _code.toString().toUpperCase() +
                                  " \n Veuillez saisir ce code dans un bref dèlai";
                            //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

                            final sendReport = await send(message, smtpServer);

                            _speak(
                                "Un code à 5 chiffres a été envoyé sur l'adresse mail saisi. Consulter votre boite mail et renseignez le . Merci");
                            provider.affiche_false();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ValidateUserEmail(
                                        email: email,
                                        user_nom: nom,
                                        user_prenom: prenom,
                                        user_telephone: numero,
                                        user_date_naissance: _date.text,
                                        sexe: sexe,
                                        user_password: password,
                                        code: _code)));
                          }
                        } catch (e) {
                          provider.affiche_false();
                          _speak("Une erreur s'est produite");
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur s'est produite !",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
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
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // ignore: prefer_const_literals_to_create_immutables

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "Avrez vous déjà un compte ?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 6,
                          color: Colors.white,
                          style: BorderStyle.solid)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginPage())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Connectez vous maintenant",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 22),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 42,
              ),
              SizedBox(
                height: 20,
              ),
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
