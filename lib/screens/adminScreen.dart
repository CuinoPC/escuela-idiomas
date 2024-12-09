import 'package:flutter/material.dart';
import 'package:escuela/controllers/userController..dart';
import 'package:escuela/screens/editButtonScreen.dart';
import 'package:escuela/screens/registerScreen.dart';
import 'package:escuela/models/user.dart';
import 'package:data_table_2/data_table_2.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final UserController userController = UserController();
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _futureUsers = userController.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              ).then((_) => _loadUsers()); // Recargar usuarios al regresar
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
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
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmar eliminación'),
                                      content: Text(
                                          '¿Estás seguro de que deseas eliminar este usuario?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;

                            if (confirmDelete) {
                              try {
                                await userController.deleteUser(user.matricula);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Usuario eliminado exitosamente')),
                                );
                                _loadUsers(); // Refrescar usuarios después de eliminar
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error al eliminar el usuario: $e')),
                                );
                              }
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final updatedUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditUserScreen(user: user),
                              ),
                            );

                            if (updatedUser != null) {
                              try {
                                await userController.updateUser(
                                    user.matricula, updatedUser);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Usuario actualizado exitosamente')),
                                );
                                _loadUsers(); // Refrescar usuarios después de editar
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error al actualizar el usuario: $e')),
                                );
                              }
                            }
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
