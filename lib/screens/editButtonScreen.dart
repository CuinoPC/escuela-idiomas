import 'package:flutter/material.dart';
import 'package:escuela/models/user.dart';

class EditUserScreen extends StatelessWidget {
  final User user;

  EditUserScreen({required this.user});

  final _formKey = GlobalKey<FormState>();
  late String name = user.name;
  late String role = user.role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario'),
        backgroundColor: Color(0xFF00897B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Editar Información',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00897B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: user.name,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => name = value,
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: role,
                            decoration: InputDecoration(
                              labelText: 'Rol',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'admin',
                                child: Text('Administrador'),
                              ),
                              DropdownMenuItem(
                                value: 'profesor',
                                child: Text('Profesor'),
                              ),
                              DropdownMenuItem(
                                value: 'alumno',
                                child: Text('Alumno'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) role = value;
                            },
                          ),
                          SizedBox(height: 30),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF00897B),
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Icon(Icons.save, color: Colors.white),
                            label: Text(
                              'Guardar Cambios',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(
                                  context,
                                  User(
                                    matricula: user.matricula,
                                    name: name,
                                    role: role,
                                    password: user.password,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
