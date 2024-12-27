class MyListModel {
  final String userID;
  final List<String> filmID;

  MyListModel({required this.userID, List<String>? filmID})
      : filmID = filmID ?? [];

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      'filmID': filmID,
    };
  }

  factory MyListModel.fromMap(Map<String, dynamic> map, String userID) {
    return MyListModel(
      userID: userID,
      filmID: List<String>.from(map['filmID'] ?? []),
    );
  }
}
