import 'package:escuela/controllers/userController..dart';
import 'package:flutter/material.dart';
import 'package:escuela/models/user.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:escuela/screens/registerScreen.dart'; // Importa la pantalla de registro

class UserManagementScreen extends StatelessWidget {
  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Redirige a la pantalla para registrar un nuevo usuario
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: userController.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles'));
          } else {
            final users = snapshot.data!;
            return DataTable2(
              columnSpacing: 12,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 0, 150, 136)),
              minWidth: 600,
              border: TableBorder.all(),
              columns: [
                DataColumn(label: Text('Matrícula')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Rol')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: users.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user.matricula)),
                  DataCell(Text(user.name)),
                  DataCell(Text(user.role)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Lógica para editar usuario
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Lógica para eliminar usuario
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
