// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Voyages {
  final String uid;
  final String user_uid;
  final String nom;
  final String lieu_depart;
  final String lieu_destination;
  final String heure_depart;
  final String created_at;
  final int nombre_place;
  final int nombre_restant;
  final int duree_voyage;
  final int montant;
  final String photo;
  Voyages({
    required this.uid,
    required this.user_uid,
    required this.nom,
    required this.lieu_depart,
    required this.lieu_destination,
    required this.heure_depart,
    required this.created_at,
    required this.nombre_place,
    required this.nombre_restant,
    required this.duree_voyage,
    required this.montant,
    required this.photo,
  });

  factory Voyages.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    return Voyages(
        photo: (document.data() as Map<String, dynamic>)['photo'],
        uid: document.id,
        user_uid: (document.data() as Map<String, dynamic>)['user_uid'],
        nom: (document.data() as Map<String, dynamic>)['nom'],
        lieu_depart: (document.data() as Map<String, dynamic>)['lieu_depart'],
        lieu_destination:
            (document.data() as Map<String, dynamic>)['lieu_destination'],
        heure_depart: (document.data() as Map<String, dynamic>)['heure_depart'],
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
        nombre_place: (document.data() as Map)['nombre_place'],
        nombre_restant: (document.data() as Map)['nombre_restant'],
        duree_voyage: (document.data() as Map)['duree_voyage'],
        montant: (document.data() as Map)['montant']);
  }

  Voyages copyWith({
    String? uid,
    String? user_uid,
    String? nom,
    String? lieu_depart,
    String? lieu_destination,
    String? heure_depart,
    String? created_at,
    int? nombre_place,
    int? nombre_restant,
    int? duree_voyage,
    int? montant,
    String? photo,
  }) {
    return Voyages(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      nom: nom ?? this.nom,
      lieu_depart: lieu_depart ?? this.lieu_depart,
      lieu_destination: lieu_destination ?? this.lieu_destination,
      heure_depart: heure_depart ?? this.heure_depart,
      created_at: created_at ?? this.created_at,
      nombre_place: nombre_place ?? this.nombre_place,
      nombre_restant: nombre_restant ?? this.nombre_restant,
      duree_voyage: duree_voyage ?? this.duree_voyage,
      montant: montant ?? this.montant,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'nom': nom});
    result.addAll({'lieu_depart': lieu_depart});
    result.addAll({'lieu_destination': lieu_destination});
    result.addAll({'heure_depart': heure_depart});
    result.addAll({'created_at': created_at});
    result.addAll({'nombre_place': nombre_place});
    result.addAll({'nombre_restant': nombre_restant});
    result.addAll({'duree_voyage': duree_voyage});
    result.addAll({'montant': montant});
    result.addAll({'photo': photo});

    return result;
  }

  factory Voyages.fromMap(Map<String, dynamic> map) {
    return Voyages(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      nom: map['nom'] ?? '',
      lieu_depart: map['lieu_depart'] ?? '',
      lieu_destination: map['lieu_destination'] ?? '',
      heure_depart: map['heure_depart'] ?? '',
      created_at: map['created_at'] ?? '',
      nombre_place: map['nombre_place']?.toInt() ?? 0,
      nombre_restant: map['nombre_restant']?.toInt() ?? 0,
      duree_voyage: map['duree_voyage']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      photo: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Voyages.fromJson(String source) =>
      Voyages.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Voyages(uid: $uid, user_uid: $user_uid, nom: $nom, lieu_depart: $lieu_depart, lieu_destination: $lieu_destination, heure_depart: $heure_depart, created_at: $created_at, nombre_place: $nombre_place, nombre_restant: $nombre_restant, duree_voyage: $duree_voyage, montant: $montant, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Voyages &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.nom == nom &&
        other.lieu_depart == lieu_depart &&
        other.lieu_destination == lieu_destination &&
        other.heure_depart == heure_depart &&
        other.created_at == created_at &&
        other.nombre_place == nombre_place &&
        other.nombre_restant == nombre_restant &&
        other.duree_voyage == duree_voyage &&
        other.montant == montant &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user_uid.hashCode ^
        nom.hashCode ^
        lieu_depart.hashCode ^
        lieu_destination.hashCode ^
        heure_depart.hashCode ^
        created_at.hashCode ^
        nombre_place.hashCode ^
        nombre_restant.hashCode ^
        duree_voyage.hashCode ^
        montant.hashCode ^
        photo.hashCode;
  }
}
