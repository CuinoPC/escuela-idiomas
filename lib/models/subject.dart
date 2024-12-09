class Subject {
  final String name;

  Subject({required this.name});

  // Factory constructor para crear una instancia de Subject a partir de un mapa JSON
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
    );
  }
}
