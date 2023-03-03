// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Tickets {
  final String uid;
  final String user_uid;
  final String voyage_uid;
  final String destination;
  final String created_at;
  final String created_at_heure;
  final String identifiant;
  Tickets({
    required this.uid,
    required this.user_uid,
    required this.voyage_uid,
    required this.destination,
    required this.created_at,
    required this.created_at_heure,
    required this.identifiant,
  });

  factory Tickets.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    return Tickets(
        uid: document.id,
        user_uid: (document.data() as Map<String, dynamic>)['user_uid'],
        voyage_uid: (document.data() as Map<String, dynamic>)['voyage_uid'],
        destination: (document.data() as Map<String, dynamic>)['destination'],
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
        created_at_heure: DateFormat("HH:mm:ss").format(created.toDate()),
        identifiant: (document.data() as Map<String, dynamic>)['identifiant']);
  }

  Tickets copyWith({
    String? uid,
    String? user_uid,
    String? voyage_uid,
    String? destination,
    String? created_at,
    String? created_at_heure,
    String? identifiant,
  }) {
    return Tickets(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      voyage_uid: voyage_uid ?? this.voyage_uid,
      destination: destination ?? this.destination,
      created_at: created_at ?? this.created_at,
      created_at_heure: created_at_heure ?? this.created_at_heure,
      identifiant: identifiant ?? this.identifiant,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'voyage_uid': voyage_uid});
    result.addAll({'destination': destination});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_heure': created_at_heure});
    result.addAll({'identifiant': identifiant});

    return result;
  }

  factory Tickets.fromMap(Map<String, dynamic> map) {
    return Tickets(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      voyage_uid: map['voyage_uid'] ?? '',
      destination: map['destination'] ?? '',
      created_at: map['created_at'] ?? '',
      created_at_heure: map['created_at_heure'] ?? '',
      identifiant: map['identifiant'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tickets.fromJson(String source) =>
      Tickets.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tickets(uid: $uid, user_uid: $user_uid, voyage_uid: $voyage_uid, destination: $destination, created_at: $created_at, created_at_heure: $created_at_heure, identifiant: $identifiant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tickets &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.voyage_uid == voyage_uid &&
        other.destination == destination &&
        other.created_at == created_at &&
        other.created_at_heure == created_at_heure &&
        other.identifiant == identifiant;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user_uid.hashCode ^
        voyage_uid.hashCode ^
        destination.hashCode ^
        created_at.hashCode ^
        created_at_heure.hashCode ^
        identifiant.hashCode;
  }
}
