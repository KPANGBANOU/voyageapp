// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modals/user.dart';
import '../modals/voyage.dart';

class ServiceDB {
  final FirebaseFirestore _Ref = FirebaseFirestore.instance;
  Stream<donnesUtilisateur> user_data(String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .snapshots()
        .map((snap) => donnesUtilisateur.fromFiresotre(snap));
  }

  Stream<donnesUtilisateur> get currentuserdata {
    return _Ref.collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((event) => donnesUtilisateur.fromFiresotre(event));
  }

  Stream<List<Voyages>> get list_voyages {
    return FirebaseFirestore.instance.collection("voyages").snapshots().map(
        (event) => event.docs.map((e) => Voyages.FromFirestore(e)).toList());
  }

  Stream<Voyages> voyage(String voyage_uid) {
    return FirebaseFirestore.instance
        .collection("voyages")
        .doc(voyage_uid)
        .snapshots()
        .map((event) => Voyages.FromFirestore(event));
  }
}
