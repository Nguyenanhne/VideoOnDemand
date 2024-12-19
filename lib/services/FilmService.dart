import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

import "../models/film_model.dart";

class FilmService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<FilmModel?> fetchFilmById(String id) async {
    try {
      final doc = await firestore.collection('Film').doc(id).get();

      if (doc.exists && doc.data() != null) {
        return FilmModel.fromMap(doc.data()! as Map<String, dynamic>);
      } else {
        print('Film not found');
        return null;
      }
    } catch (e) {
      print('Error fetching film: $e');
      return null;
    }
  }

}