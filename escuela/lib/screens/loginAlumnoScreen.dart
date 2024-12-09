import 'package:escuela/controllers/userController..dart';
import 'package:escuela/screens/studentScreen.dart';
import 'package:flutter/material.dart';

class LoginAlumnoScreen extends StatefulWidget {
  @override
  _LoginAlumnoScreenState createState() => _LoginAlumnoScreenState();
}

class _LoginAlumnoScreenState extends State<LoginAlumnoScreen> {
  final matriculaController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userController = UserController();
      final user = await userController.loginUser(
        matriculaController.text,
        passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (user != null && user['role'] == 'alumno') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentGradesScreen()),
        );
      } else {
        _showErrorDialog("Credenciales incorrectas o rol no autorizado.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog("Error en el login.");
    }
  }

  void _showErrorDialog(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login de Alumno'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Inicia sesión como Alumno',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo Matrícula con Icono
                  _buildTextField(
                    controller: matriculaController,
                    label: 'Matrícula',
                    icon: Icons.account_circle,
                  ),
                  SizedBox(height: 20),
                  // Campo Contraseña con Icono
                  _buildTextField(
                    controller: passwordController,
                    label: 'Contraseña',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  // Botón de Login
                  isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                        )
                      : ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Iniciar sesión',
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
}
