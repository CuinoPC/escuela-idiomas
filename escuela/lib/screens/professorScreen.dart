import 'package:flutter/material.dart';

class ProfessorGradesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Map<String, dynamic>> grades = [
      {'subject': 'Matemáticas', 'grade': 9},
      {'subject': 'Ciencias', 'grade': 6},
      {'subject': 'Historia', 'grade': 8},
      {'subject': 'Arte', 'grade': 7},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Calificaciones de Estudiantes')),
      body: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          final grade = grades[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    grade['grade'] >= 7 ? Colors.green : Colors.red,
                child: Text(
                  grade['grade'].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(grade['subject']),
              subtitle: Text('Calificación: ${grade['grade']}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Lógica para mostrar un diálogo de edición
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Editar calificación'),
                        content: Text('Aquí puedes editar la calificación.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Guardar cambios
                              Navigator.pop(context);
                            },
                            child: Text('Guardar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
