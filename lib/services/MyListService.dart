import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/film_model.dart';
import 'FilmService.dart';

class MyListService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> createMyList(String userID, List<String>filmID) async {
    try {
      DocumentReference docRef = await firestore.collection('My List').add({
        'userID': userID,
        'filmID': filmID,
      });
      print("My List created with ID: ${docRef.id}");
    } catch (e) {
      print("Error creating document: $e");
    }
  }

  Future<void> addFilm(String userID, String filmID) async {
    try {
      await firestore.collection('users').doc(userID).update({
        'filmIDs': FieldValue.arrayUnion([filmID]),
      });
      print("Film added to user's list.");
    } catch (e) {
      print("Error adding film: $e");
    }
  }

  Future<void> addFilmToMyList(String userID, String filmID) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('My List')
          .where('userID', isEqualTo: userID)
          .get();

      if (snapshot.docs.isEmpty) {
        await firestore.collection('My List').add({
          'userID': userID,
          'filmID': [filmID],
        });
        print("My List created with filmID: $filmID");
      } else {
        DocumentReference docRef = snapshot.docs[0].reference;
        await docRef.update({
          'filmID': FieldValue.arrayUnion([filmID]),
        });
        print("Film added to My List for user $userID.");
      }
    } catch (e) {
      print("Error adding film to My List: $e");
    }
  }

  Future<void> removeFilmFromMyList(String userID, String filmID) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('My List')
          .where('userID', isEqualTo: userID)
          .get();
      if (snapshot.docs.isEmpty) {
        print("No list found for user $userID.");
      } else {
        DocumentReference docRef = snapshot.docs[0].reference;
        await docRef.update({
          'filmID': FieldValue.arrayRemove([filmID]),
        });
        print("Film removed from My List for user $userID.");
      }
    } catch (e) {
      print("Error removing film from My List: $e");
    }
  }

  Future<bool> isFilmInMyList(String userID, String filmID) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('My List')
          .where('userID', isEqualTo: userID)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No list found for user $userID.");
        return false;
      } else {
        List<dynamic> filmIDs = snapshot.docs[0].get('filmID');
        return filmIDs.contains(filmID);
      }
    } catch (e) {
      print("Error checking film in My List: $e");
      return false;
    }
  }

  Future<List<String>> fetchMyListFilmIDs(String userID) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('My List')
          .where('userID', isEqualTo: userID)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No list found for user $userID.");
        return [];
      }

      List<String> filmIDs = [];
      for (var doc in snapshot.docs) {
        var filmIDList = List<String>.from(doc.get('filmID') ?? []);
        filmIDs.addAll(filmIDList);
      }
      print("id ${filmIDs.length}");
      return filmIDs;
    } catch (e) {
      print("Error fetching film IDs for user $userID: $e");
      throw Exception('Failed to fetch film IDs: $e');
    }
  }

  // Future<Map<String, dynamic>> fetchMyListFilms({
  //   required String userID,
  //   required int limit,
  //   required DocumentSnapshot? lastDocument,
  // }) async {
  //   try {
  //     // Tạo truy vấn để lấy danh sách "My List" của người dùng
  //     Query query = firestore
  //         .collection('My List')
  //         .where('userID', isEqualTo: userID)
  //         .limit(limit);
  //
  //     // Áp dụng phân trang nếu đã có lastDocument
  //     if (lastDocument != null) {
  //       query = query.startAfterDocument(lastDocument);
  //     }
  //
  //     // Thực hiện truy vấn
  //     final snapshot = await query.get();
  //
  //     if (snapshot.docs.isEmpty) {
  //       print("No more films found for user $userID.");
  //       return {
  //         'films': [],
  //         'lastDocument': null,
  //       };
  //     }
  //
  //     // Lấy danh sách filmID
  //     List<String> filmIDs = List<String>.from(snapshot.docs[0].get('filmID') ?? []);
  //
  //     // Lấy thông tin chi tiết từng phim
  //     List<FilmModel> films = [];
  //     for (String filmID in filmIDs) {
  //       final filmData = await firestore.collection('Film').doc(filmID).get();
  //       if (filmData.exists) {
  //         FilmModel film = FilmModel.fromMap(filmData.data()! as Map<String, dynamic>, filmData.id);
  //
  //         // Lấy URL hình ảnh nếu cần
  //         final imageUrl = await getImageUrl(film.id);
  //         film.setUrl(imageUrl);
  //
  //         films.add(film);
  //       }
  //     }
  //
  //     return {
  //       'films': films,
  //       'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
  //     };
  //   } catch (e) {
  //     print("Error fetching My List films: $e");
  //     throw Exception('Failed to fetch My List films: $e');
  //   }
  // }

  Future<String> getImageUrl(String id) async {
    try {
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