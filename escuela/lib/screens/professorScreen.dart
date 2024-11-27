import 'package:flutter/material.dart';
import 'package:escuela/controllers/gradeController.dart';
import 'package:escuela/models/grade.dart';

class ProfessorGradesScreen extends StatelessWidget {
  final GradeController gradeController = GradeController();
  final String studentId = '123'; // Este debe ser el ID del estudiante

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calificaciones de Estudiantes')),
      body: FutureBuilder<List<Grade>>(
        future: gradeController.fetchGradesByStudent(studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay calificaciones disponibles'));
          } else {
            final grades = snapshot.data!;
            return ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final grade = grades[index];
                return ListTile(
                  title: Text(grade.subject),
                  subtitle: Text('Calificación: ${grade.grade}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Lógica para modificar calificación
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
