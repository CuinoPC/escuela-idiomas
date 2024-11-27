import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:escuela/models/grade.dart';

class GradeController {
  final String baseUrl = 'http://localhost:3000/api/grades'; // URL de tu API

  // Obtener las calificaciones por profesor
  Future<List<Grade>> fetchGradesByProfessor(String professorId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?professorId=$professorId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((grade) => Grade.fromJson(grade)).toList();
    } else {
      throw Exception('Error al cargar las calificaciones');
    }
  }

  // Actualizar calificación de un estudiante
  Future<void> updateGrade(String studentId, String newGrade) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$studentId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'grade': newGrade}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la calificación');
    }
  }

  // Obtener las calificaciones por estudiante
  Future<List<Grade>> fetchGradesByStudent(String studentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?studentId=$studentId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((grade) => Grade.fromJson(grade)).toList();
    } else {
      throw Exception('Error al cargar las calificaciones');
    }
  }
}
