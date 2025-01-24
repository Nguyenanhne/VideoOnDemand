import "dart:ffi";
import "dart:math";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:du_an_cntt/services/RatingService.dart";
import "package:firebase_storage/firebase_storage.dart";
import "../models/film_model.dart";


class FilmService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final ratingService = RatingService();

  Future<FilmModel?> fetchFilmByID(String id) async {
    try {
      // Lấy tài liệu từ Firestore
      final doc = await firestore.collection('Film').doc(id).get();
      if (doc.exists && doc.data() != null) {
        final film = FilmModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
        final imageUrl = await getImageUrl(id);
        film.setUrl(imageUrl);
        return film;
      } else {
        print('Film not found');
        return null;
      }
    } catch (e) {
      print('Error fetching film: $e');
      return null;
    }
  }

  // Future<List<MovieModel>> fetchListFilm({required int limit, required DocumentSnapshot? lastDocument}) async {
  //   try {
  //     Query query  = firestore.collection('Film').limit(limit);
  //
  //     if (lastDocument != null) {
  //       query = query.startAfterDocument(lastDocument);
  //     }
  //
  //     final snapshot = await query.get();
  //
  //     List<MovieModel> films = snapshot .docs.map((doc) {
  //       return MovieModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
  //     }).toList();
  //
  //     //url image
  //     for (var film in films) {
  //       final imageUrl = await getImageUrl(film.id);
  //       film.setUrl(imageUrl);
  //     }
  //
  //     return films;
  //
  //   } catch (e) {
  //     print('Error fetching films: $e');
  //     throw Exception('Failed to fetch films: $e');
  //   }
  // }

  Future<Map<String, dynamic>> fetchListFilm({
    required int limit,
    required DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = firestore.collection('Film').limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      List<FilmModel> films = snapshot.docs.map((doc) {
        return FilmModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
      }).toList();

      for (var film in films) {
        final imageUrl = await getImageUrl(film.id);
        film.setUrl(imageUrl);
      }

      return {
        'films': films,
        'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
      };
    } catch (e) {
      print('Error fetching films: $e');
      throw Exception('Failed to fetch films: $e');
    }
  }

  Future<Map<String, dynamic>> searchByTypeAndYear({
        required String? year,
        required String? type,
        required int limit,
        required DocumentSnapshot? lastDocument,
      }) async {
    try {
      Query query = firestore.collection('Film').limit(limit);

      // Thêm điều kiện nếu genre không null
      if (type != null) {
        query = query.where('type', arrayContains: type);
      }

      // Thêm điều kiện nếu year không null
      if (year != null) {
        int yearInt = int.tryParse(year) ?? 0;
        query = query.where('year', isEqualTo: yearInt);
      }

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      List<FilmModel> films = snapshot.docs.map((doc) {
        return FilmModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      print(films.length);
      for (var film in films) {
        final imageUrl = await getImageUrl(film.id);
        film.setUrl(imageUrl);
      }

      return {
        'films': films,
        'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
      };

    } catch (e) {
      print('Error searching by type: $e');
      throw Exception('Failed to searching films: $e');
    }
  }


  Future<List<FilmModel>> searchFilmNamesByName(String nameQuery) async {
    try {
      String upperCaseQuery = nameQuery.toUpperCase();
      QuerySnapshot querySnapshot = await firestore.collection('Film')
          .where('upperName', isGreaterThanOrEqualTo: upperCaseQuery)
          .where('upperName', isLessThanOrEqualTo: upperCaseQuery + '\uf8ff')
          .get();

      List<FilmModel> films = querySnapshot.docs.map((doc) {
        return FilmModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return films;

    } catch (e) {
      print('Error searching film names: $e');
      return [];
    }
  }

  Future<String> getImageUrl(String id) async {
    try {
      final ref = storage.ref().child('Poster/$id.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      final defaultRef = storage.ref().child('test.jpg');
      final defaultUrl = await defaultRef.getDownloadURL();
      return defaultUrl;
    }
  }

  Future<Map<String, dynamic>> searchByMultipleTypes(
      List<String> genres, {
        required int limit,
        required DocumentSnapshot? lastDocument,
      }) async {
    try {
      Query query = firestore
          .collection('Film')
          .where('type', arrayContainsAny: genres)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      List<FilmModel> films = snapshot.docs.map((doc) {
        return FilmModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      for (var film in films) {
        final imageUrl = await getImageUrl(film.id);
        film.setUrl(imageUrl);
      }

      return {
        'films': films,
        'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null, // Phân trang
      };
    } catch (e) {
      print('Error searching by multiple types: $e');
      throw Exception('Failed to search films: $e');
    }
  }

  Future<void> updateTotalView(String filmID) async {
    try {
      DocumentReference filmDoc = firestore.collection('Film').doc(filmID);

      await filmDoc.update({
        'viewTotal': FieldValue.increment(1),
      });
      print('Total view incremented by 1 for film ID: $filmID');
    } catch (e) {
      print('Failed to increment totalView: $e');
    }
  }


  Future<FilmModel?> fetchRandomFilm() async {
    try {
      final snapshot = await firestore.collection('Film').get();
      final totalDocs = snapshot.size;

      if (totalDocs == 0) {
        print('No films found');
        return null;
      }
      print("fetch");
      final randomIndex = Random().nextInt(totalDocs);

      final randomDoc = snapshot.docs[randomIndex];

      final film = FilmModel.fromMap(randomDoc.data() as Map<String, dynamic>, randomDoc.id);

      final imageUrl = await getImageUrl(film.id);
      film.setUrl(imageUrl);

      return film;
    } catch (e) {
      print('Error fetching random film: $e');
      return null;
    }
  }
}