import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/film_rating.dart';

class RatingService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveOrUpdateRating(RatingModel rating) async {
    try {
      CollectionReference ratingsRef = await firestore.collection('Rating');
      final existingRating = await ratingsRef
          .where('filmID', isEqualTo: rating.filmID)
          .where('userID', isEqualTo: rating.userID)
          .get();

      if (existingRating.docs.isNotEmpty) {
        await ratingsRef
            .doc(existingRating.docs.first.id)
            .update({
          'rating': rating.rating,
        });
      }else {
        await ratingsRef.add(rating.toMap());
      }
    } catch (e) {
      print("Error saving or updating rating: $e");
      rethrow;
    }
  }
  Future<void> deleteRating(String movieID, String userID) async {
    try {
      CollectionReference ratingsRef = await firestore.collection('Rating');
      final querySnapshot = await ratingsRef
          .where('filmID', isEqualTo: movieID)
          .where('userID', isEqualTo: userID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await ratingsRef.doc(querySnapshot.docs.first.id).delete();
        print("Delete Rating");
      }
    } catch (e) {
      print("Error deleting rating: $e");
    }
  }
  Future<bool?> getRatingStatus(String filmID, String userID) async {
    try {
    CollectionReference ratingsRef = await firestore.collection('Rating');
    final querySnapshot = await ratingsRef
          .where('filmID', isEqualTo: filmID)
          .where('userID', isEqualTo: userID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final ratingData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return ratingData['rating'] as bool;
      } else {
        return null;
      }
    } catch (e) {
      print("Error checking rating status: $e");
      rethrow;
    }
  }
  Future<int> getTotalLikesByFilmID(String filmID) async {
    QuerySnapshot snapshot = await firestore.collection('Rating')
        .where('filmID', isEqualTo: filmID)
        .where('rating', isEqualTo: true)
        .get();

    return snapshot.docs.length;
  }
  Future<int> getTotalDisLikesByFilmID(String filmID) async {
    QuerySnapshot snapshot = await firestore.collection('Rating')
        .where('filmID', isEqualTo: filmID)
        .where('rating', isEqualTo: false)
        .get();
    return snapshot.docs.length;
  }

}
