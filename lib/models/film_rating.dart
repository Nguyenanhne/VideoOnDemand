import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String id;
  final String filmID;
  final String userID;
  final bool rating;

  RatingModel({
    required this.id,
    required this.filmID,
    required this.userID,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'filmID': filmID,
      'userID': userID,
      'rating': rating,
    };
  }
}
