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

  factory RatingModel.fromMap(String id, Map<String, dynamic> data) {
    return RatingModel(
      id: id,
      filmID: data['filmID'] ?? '',
      userID: data['userID'] ?? '',
      rating: data['rating'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'filmID': filmID,
      'userID': userID,
      'rating': rating,
    };
  }
}
