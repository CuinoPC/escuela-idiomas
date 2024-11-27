class Grade {
  final String subject;
  final double grade;

  Grade({required this.subject, required this.grade});

  // Método para convertir JSON a objeto Grade
  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      subject: json['subject'],
      grade: json['grade'],
    );
  }
}
