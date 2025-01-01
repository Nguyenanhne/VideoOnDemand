class MovieModel {
  final String id;
  final List<String> actors;
  final String age;
  final String description;
  final String director;
  final String name;
  final String note;
  final String year;
  String url = "";

  MovieModel({
    required this.id,
    required this.actors,
    required this.age,
    required this.description,
    required this.director,
    required this.name,
    required this.note,
    required this.year,
  });

  // Convert FilmModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'actors': actors.join(", "),
      'age': age,
      'description': description,
      'director': director,
      'name': name,
      'note': note,
      'year': year,
    };
  }

  // Create FilmModel from Map
  factory MovieModel.fromMap(Map<String, dynamic> map, String id) {
    return MovieModel(
      id: id,
      actors: (map['actors'] as String).split(', ').map((actor) => actor.trim()).toList(),
      age: map['age'].toString() ?? '' ,
      description: map['description'] ?? '',
      director: map['director'] ?? '',
      name: map['name'] ?? '',
      note: map['note'] ?? '',
      year: map['year'].toString() ?? '',
    );
  }
  void setUrl(String newUrl) {
    url = newUrl;
  }
}
