class Professor {
  final String name;

  Professor({required this.name});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      name: json['name'],
    );
  }
}
