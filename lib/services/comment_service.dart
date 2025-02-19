import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/models/comment_model.dart';
import 'package:du_an_cntt/services/user_service.dart';

import 'firebase_authentication.dart';

class CommentService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<CommentModel?> addComment({
    required String filmID,
    required String userID,
    required String content,
    required String email,
  }) async {
    try {

      QuerySnapshot querySnapshot = await firestore
          .collection('Comment')
          .where('filmID', isEqualTo: filmID)
          .where('userID', isEqualTo: userID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Nếu comment tồn tại, cập nhật nó
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'content': content,
          'timestamp': FieldValue.serverTimestamp(),
        });
        DocumentSnapshot docSnap = await docRef.get();
        if (docSnap.exists) {return CommentModel.fromMap(docSnap.id, docSnap.data() as Map<String, dynamic>);
        }
        else {
          return null;
        }
      }
      else{
        DocumentReference docRef = await firestore.collection('Comment').add({
          'filmID': filmID,
          'userID': userID,
          'content': content,
          'email': email,
          'timestamp': FieldValue.serverTimestamp(),
        });

        DocumentSnapshot docSnap = await docRef.get();
        if (docSnap.exists) {return CommentModel.fromMap(docSnap.id, docSnap.data() as Map<String, dynamic>);
        }
        else {
          return null;
        }
      }
    } catch (e) {
      print("Lỗi khi thêm comment: $e");
      return null;
    }
  }

  Future<CommentModel?> getCommentsByUserAndFilm({
    required String userID,
    required String filmID,
  }) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("Comment")
          .where("userID", isEqualTo: userID)
          .where("filmID", isEqualTo: filmID)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        CommentModel comment = CommentModel.fromMap(
          querySnapshot.docs.first.id, // ID của document
          querySnapshot.docs.first.data() as Map<String, dynamic>,
        );
        return comment;
      } else {
        print("Không tìm thấy comment nào.");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy comment: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchListComments({
    required String filmID,
    required int limit,
    required DocumentSnapshot? lastDocument,
  }) async{
    final userID = await Auth().getUserID();
    List<CommentModel> comments = [];
    try {
      Query query = firestore.collection('Comment').limit(limit).where("filmID", isEqualTo: filmID);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot= await query.get();

      if (querySnapshot.docs.isEmpty) {
        print("No records comment found for $filmID");
        return {
          'comments': comments,
          'lastDocument': null,
        };
      }
      comments = querySnapshot.docs.map((doc) {
        return CommentModel.fromMap(doc.id, doc.data()! as Map<String, dynamic>);
      }).toList();

      return {
        'comments': comments,
        'lastDocument': querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      };
    } catch (e) {
      print('Error fetching comments: $e');
      return {
        'comments': comments,
        'lastDocument': null,
      };
    }
  }
}