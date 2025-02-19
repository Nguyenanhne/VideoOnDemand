import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String filmID;
  final String userID;
  final String email;
  final String content;
  final DateTime timestamp;

  CommentModel({
    required this.email,
    required this.id,
    required this.filmID,
    required this.userID,
    required this.content,
    required this.timestamp,
  });

  factory CommentModel.fromMap(String id, Map<String, dynamic> map) {
    return CommentModel(
      id: id,
      email: map['email'] ?? id,
      filmID: map['filmID'] ?? '',
      userID: map['userID'] ?? '',
      content: map['content'] ?? 'Phim hay quá',
      timestamp: (map['timestamp'] is Timestamp) ? (map['timestamp'] as Timestamp).toDate() : DateTime.now(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'filmID': filmID,
      'userID': userID,
      'content': content,
      'timestamp': timestamp,
      'name': email
    };
  }
}