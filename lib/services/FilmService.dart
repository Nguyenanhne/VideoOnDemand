import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";

import "../models/film_model.dart";

class FilmService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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
  Future<List<FilmModel>> fetchListFilm({required int limit, required DocumentSnapshot? lastDocument}) async {
    try {
      Query query  = firestore.collection('Film').limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      List<FilmModel> films = snapshot .docs.map((doc) {
        return FilmModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
      }).toList();

      //url image
      for (var film in films) {
        final imageUrl = await getImageUrl(film.id);
        film.setUrl(imageUrl);
      }

      return films;

    } catch (e) {
      print('Error fetching films: $e');

      throw Exception('Failed to fetch films: $e');
    }
  }

  Future<String> getImageUrl(String id) async {
    try {
      print(id);
      final ref = storage.ref().child('Poster/$id.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image URL: $e');
       final defaultRef = storage.ref().child('test.jpg');
      final defaultUrl = await defaultRef.getDownloadURL();
      return defaultUrl;
    }
  }
}