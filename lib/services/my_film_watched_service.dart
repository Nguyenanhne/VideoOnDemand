import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFilmWatchedService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveFilmPosition({
    required String userID,
    required String filmID,
    required int position,
  }) async {
    try {
      final querySnapshot = await firestore
          .collection('My Film Watched')
          .where('userID', isEqualTo: userID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        final docID= querySnapshot.docs.first.id;

        final filmDoc = firestore.collection('My Film Watched').doc(docID);

        await filmDoc.update({
          'videoPosition.$filmID': position,
        });

        print("Updated position for user $userID: film $filmID at position $position");

      } else {
        await firestore.collection('My Film Watched').add({
          'userID': userID,
          'videoPosition': {filmID: position},
        });

        print("Created new record for user $userID: film $filmID at position $position");
      }
    } catch (e) {
      print("Failed to save position: $e");
    }
  }
  Future<List<String>> fetchListFilmIDbyUserID() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return [];
    }
    final userID = user.uid;

    try {
      final querySnapshot = await firestore
          .collection('My Film Watched')
          .where('userID', isEqualTo: userID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docData = querySnapshot.docs.first.data();

        final Map<String, dynamic> videoPosition =
            docData['videoPosition'] as Map<String, dynamic>? ?? {};

        return videoPosition.keys.toList();
      } else {
        print("No records found for user $userID");
        return [];
      }
    } catch (e) {
      print("Error fetching film list for user $userID: $e");
      return [];
    }
  }
  Future<int> getPositionByFilmID(String filmID) async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return 0;
    }
    final userID = user.uid;
    try {
      final querySnapshot = await firestore
          .collection('My Film Watched')
          .where('userID', isEqualTo: userID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docData = querySnapshot.docs.first.data();

        final Map<String, dynamic> videoPosition =
            docData['videoPosition'] as Map<String, dynamic>? ?? {};

        return videoPosition[filmID] ?? 0;
      } else {
        print("No records found for user $userID");
        return 0;
      }
    } catch (e) {
      print("Error fetching position for user $userID, film $filmID: $e");
      return 0;
    }
  }

}