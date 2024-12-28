import 'package:cloud_firestore/cloud_firestore.dart';

class MyListService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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


}