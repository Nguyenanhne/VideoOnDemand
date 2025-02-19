// class FilmModel {
//   final String id;
//   final List<String> actors;
//   final String age;
//   final String description;
//   final String director;
//   final String name;
//   final String note;
//   final String year;
//   final int likes;
//   final int dislikes;
//   final List<String> type;
//   String url = "";
//
//   FilmModel({
//     required this.likes,
//     required this.dislikes,
//     required this.type,
//     required this.id,
//     required this.actors,
//     required this.age,
//     required this.description,
//     required this.director,
//     required this.name,
//     required this.note,
//     required this.year,
//   });
//
//   // Convert FilmModel to Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'actors': actors.join(", "),
//       'age': age,
//       'description': description,
//       'director': director,
//       'name': name,
//       'note': note,
//       'year': year,
//       'likes': likes,
//       'dislikes': dislikes
//     };
//   }
//
//   // Create FilmModel from Map
//   factory FilmModel.fromMap(Map<String, dynamic> map, String id) {
//     return FilmModel(
//       id: id,
//       actors: (map['actors'] as String).split(', ').map((actor) => actor.trim()).toList(),
//       age: map['age'].toString() ?? '' ,
//       description: map['description'] ?? '',
//       director: map['director'] ?? '',
//       name: map['name'] ?? '',
//       note: map['note'] ?? '',
//       year: map['year'].toString() ?? '',
//       type: List<String>.from(map['type'] ?? []),
//     );
//   }
//   void setUrl(String newUrl) {
//     url = newUrl;
//   }
// }
class FilmModel {
  final String id;
  final List<String> actors;
  final String age;
  final String description;
  final String director;
  final String name;
  final String note;
  final String year;
  final int viewTotal;
  final List<String> type;
  String url = "";

  FilmModel({
    required this.type,
    required this.id,
    required this.actors,
    required this.age,
    required this.description,
    required this.director,
    required this.name,
    required this.note,
    required this.year,
    required this.viewTotal
  });
  // Create FilmModel from Map
  factory FilmModel.fromMap(Map<String, dynamic> map, String id) {
    return FilmModel(
      id: id,
      actors: map['actors'] != null ? (map['actors'] as String).split(', ').map((actor) => actor.trim()).toList() : [],
      age: map['age']?.toString() ?? '',
      description: map['description'] ?? '',
      director: map['director'] ?? '',
      name: map['name'] ?? '',
      note: map['note'] ?? '',
      viewTotal: map['viewTotal'] ?? 0,
      year: map['year']?.toString() ?? '',
      type: map['type'] != null ? List<String>.from(map['type']) : [],
    );
  }

  // Set URL for the film
  void setUrl(String newUrl) {
    url = newUrl;
  }
}
