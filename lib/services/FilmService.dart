import "package:cloud_firestore/cloud_firestore.dart";

import "../models/film_model.dart";

class FilmService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<FilmModel?> fetchFilmById(String id) async {
    try {
      final doc = await firestore.collection('Film').doc(id).get();

      if (doc.exists && doc.data() != null) {
        return FilmModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
      } else {
        print('Film not found');
        return null;
      }
    } catch (e) {
      print('Error fetching film: $e');
      return null;
    }
  }
  Future<List<FilmModel>> fetchListFilm() async {
    try {
      final snapshot  = await firestore.collection('Film').get();

      List<FilmModel> films = snapshot .docs.map((doc) {
        return FilmModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
      }).toList();

      return films;
    } catch (e) {
      print('Error fetching films: $e');

      throw Exception('Failed to fetch films: $e');
    }
  }

}