import 'package:escuela/models/professor.dart'; // Importa el modelo de Profesor
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfessorController {
  // Método para obtener todos los profesores
  Future<List<String>> fetchProfessors() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/professors'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((professor) => professor['name'] as String).toList();
    } else {
      throw Exception('Error al cargar los profesores');
    }
  }

  // Método para asignar un profesor a un estudiante
  Future<void> assignProfessorToStudent(
      String matricula, String professor) async {
    final response = await http.put(
      Uri.parse('https://api.example.com/students/$matricula/professor'),
      body: json.encode({'professor': professor}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al asignar el profesor al estudiante');
    }
  }
}
