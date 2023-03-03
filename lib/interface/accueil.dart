// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/interface/connexion.dart';
import 'package:interrogation/interface/creer_compte.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        leading: Image.asset(
          "images/icon.png",
          scale: 4.5,
          height: 80,
          width: 80,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Voyage",
          style: GoogleFonts.alike(
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
                child: Center(
                  child: Text(
                    "Bienvenue sur Voyage App",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alike(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Voyage App",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: 2,
                width: 40,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.88,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 20),
                  child: Text(
                    "Nous vous souhaitons la bienvenue sur Voyage App. Cette application va vous permettre non seulement de réserver vos places et ainsi garantir votre voyage mais aussi d'annuler votre place rservée en dernier temps en cas d'empechements majeurs. Ceci permettra à notre structure de remplacer au plus vite de nouvel passager à votre place. Plus de doute, garantissez votre voyage avec Voyage App. Pour ce faire, si c'est votre première fois de venir sur cette application, vous devez avant tout créer un compte, ceci dans le bus de connaitre l'effectif de nos clients et de vous envoyer de notifications en cas de force majeures. Si c'est dèjà fait, plus besoin de  créer le compte. Vous n'avez qu'à vous connecter en vous servant de votre identifiant ( Adresse E-Mail renseigné pendant la création de compte) et de votre mot de passe sècret. Soyez rassuré, vous n'aurez pas à le faire en tout temps. Pour garantir la sécurité de vos données, nous vous suggérons de bien vouloir vous déconnecter après chaque utilisation de l'application.\n En outre , pour démander le ticket , vous devez cliquer sur demander ticket après avoir choisi le voyage qui vous convient selon votre disponibilité bien sur. \n Explorez nos bus de confort de transports",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Voulez-vous démander votre ticket ? ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.96,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: Text(
                      "Créez d'abord votre compte".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Avez-vous déjà un compte actif sur cette application ?",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.96,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Text(
                      "Connectez vous alors".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
    );
  }
}
