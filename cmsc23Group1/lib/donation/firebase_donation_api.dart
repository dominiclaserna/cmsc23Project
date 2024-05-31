// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

const dbConnection = "donations";

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuthAPI _authAPI = FirebaseAuthAPI();

  Future< Map<String, dynamic> > addDonation(Map<String, dynamic> donation) async {
    try {
      final addedDonation = await db.collection(dbConnection).add(donation);
      final updateId = await db.collection(dbConnection).doc(addedDonation.id).update({'id': addedDonation.id});

      return {
        "success": true,
        "data": addedDonation,
        "message" : "Successfully added"
      };
    } on FirebaseException catch (err) {
      print(["There was an error, ", err]);

      return {
        "success": false,
        "data": err,
        "message": "There was an error with adding a donation to the database."
      };
    }
  }

  Stream<QuerySnapshot> getAllDonations() {
    String? uid = _authAPI.getUserUID();
    return db.collection("todos").where("uid", isEqualTo: uid).snapshots();
    // return db.collection("todos").snapshots();

    // try {
    //   final 
    // } catch (err) {

    // }
  }

}
