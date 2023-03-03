// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interrogation/interface/drawer.dart';

class AnnulerVoyage extends StatefulWidget {
  const AnnulerVoyage({super.key});

  @override
  State<AnnulerVoyage> createState() => _AnnulerVoyageState();
}

class _AnnulerVoyageState extends State<AnnulerVoyage> {
  TextEditingController numero_ticket = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int _numero = 0;

    return Scaffold(
      drawer: DrawerUser(),
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "voyage",
          style: GoogleFonts.alike(
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
                "Annulation de voyage ",
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
                  "Numéro du ticket ",
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
                  controller: numero_ticket,
                  autocorrect: true,
                  enableSuggestions: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {}, child: Text("Numero du ticket".toUpperCase()))
          ],
        ),
      ),
    );
  }
}
