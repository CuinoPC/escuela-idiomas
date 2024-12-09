import 'package:escuela/controllers/userController..dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Usuario'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Nuevo Registro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Campo Matrícula
                    _buildTextField(
                      controller: matriculaController,
                      label: 'Matrícula',
                      icon: Icons.credit_card,
                    ),
                    SizedBox(height: 16),
                    // Campo Nombre
                    _buildTextField(
                      controller: nameController,
                      label: 'Nombre',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    // Campo Rol
                    _buildTextField(
                      controller: roleController,
                      label: 'Rol (alumno/profesor)',
                      icon: Icons.school,
                    ),
                    SizedBox(height: 16),
                    // Campo Contraseña
                    _buildTextField(
                      controller: passwordController,
                      label: 'Contraseña',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    SizedBox(height: 30),
                    // Botón Registrar
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userController.createUser(
                            matriculaController.text,
                            nameController.text,
                            roleController.text,
                            passwordController.text,
                          );
                          // Mostrar mensaje de éxito
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registro exitoso'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          _showErrorDialog(
                              context, 'No se pudo registrar el usuario');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
