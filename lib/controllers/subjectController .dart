// controllers/SubjectController.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:escuela/models/subject.dart'; // Importa el modelo Subject

class SubjectController {
  // Método para obtener las materias (ahora devuelve List<Subject>)
  Future<List<Subject>> fetchSubjects() async {
    final response = await http.get(
        Uri.parse('https://escuela-idiomas-backend.onrender.com/api/subjects'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((subject) => Subject.fromJson(subject)).toList();
    } else {
      throw Exception('Error al cargar las materias');
    }
  }

  // Método para asignar materia a un estudiante
  Future<void> assignSubjectToStudent(
      String matricula, String subjectName) async {
    final response = await http.post(
      Uri.parse(
          'https://escuela-idiomas-backend.onrender.com/api/subjects/assign'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'matricula': matricula,
        'subjectName': subjectName,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al asignar la materia');
    }
  }
}
