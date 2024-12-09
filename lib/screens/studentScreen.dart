import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart'; // Asegúrate de tener este import

class StudentGradesScreen extends StatelessWidget {
  // Lista de materias (puedes agregar más o cargarla desde una fuente externa)
  final List<Map<String, String>> subjects = [
    {'subject': 'Inglés Básico', 'grade': 'A'},
    {'subject': 'Inglés Intermedio', 'grade': 'B+'},
    {'subject': 'Inglés Avanzado', 'grade': 'B'},
    {'subject': 'Francés Básico', 'grade': 'A-'},
    {'subject': 'Francés Intermedio', 'grade': 'B'},
    {'subject': 'Francés Avanzado', 'grade': 'A'},
    {'subject': 'Alemán Básico', 'grade': 'B+'},
    {'subject': 'Alemán Intermedio', 'grade': 'A'},
    {'subject': 'Alemán Avanzado', 'grade': 'B-'},
    {'subject': 'Italiano Básico', 'grade': 'A+'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Calificaciones')),
      body: DataTable2(
        columnSpacing: 12,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.teal), // Color de la fila de encabezado
        minWidth: 600,
        border: TableBorder.all(),
        columns: [
          DataColumn2(label: Text('Materia')),
          DataColumn2(label: Text('Calificación')),
        ],
        rows: subjects.map((subject) {
          return DataRow2(
            cells: [
              DataCell(Text(subject['subject']!)), // Materia
              DataCell(Text(subject['grade']!)), // Calificación
            ],
          );
        }).toList(),
      ),
    );
  }
}
