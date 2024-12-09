import 'package:escuela/controllers/userController..dart';
import 'package:escuela/screens/professorScreen.dart';
import 'package:flutter/material.dart';

class LoginProfesorScreen extends StatefulWidget {
  @override
  _LoginProfesorScreenState createState() => _LoginProfesorScreenState();
}

class _LoginProfesorScreenState extends State<LoginProfesorScreen> {
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

      if (user != null && user['role'] == 'profesor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfessorGradesScreen()),
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
        title: Text('Login de Profesor'),
        backgroundColor: Colors.teal.shade700,
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
                    'Inicia sesión como Profesor',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: matriculaController,
                    label: 'Matrícula',
                    icon: Icons.account_circle,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordController,
                    label: 'Contraseña',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.teal.shade700),
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
        prefixIcon: Icon(icon, color: Colors.teal.shade700),
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
