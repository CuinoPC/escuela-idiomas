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
        backgroundColor: Colors.teal, // Color atractivo para la AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade200,
              Colors.teal.shade600
            ], // Degradado suave
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          // Centrar el cuadro de login
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 350, // Establecer un ancho fijo
              height: 350, // Establecer un alto fijo (cuadrado)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Sombra suave
                    blurRadius: 8, // Difuminar la sombra
                    offset: Offset(0, 4), // Dirección de la sombra
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Inicia sesión como Profesor',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700, // Color para el título
                      ),
                    ),
                    SizedBox(height: 20), // Espacio entre título y campos

                    // Campo Matrícula
                    TextField(
                      controller: matriculaController,
                      decoration: InputDecoration(
                        labelText: 'Matrícula',
                        labelStyle: TextStyle(color: Colors.teal),
                        filled: true,
                        fillColor: Colors.teal.shade50, // Fondo suave
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal.shade300),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Espacio entre los campos

                    // Campo Contraseña
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.teal),
                        filled: true,
                        fillColor: Colors.teal.shade50, // Fondo suave
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal.shade300),
                        ),
                      ),
                    ),
                    SizedBox(height: 30), // Espacio entre los campos y el botón

                    // Botón de Login
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
                          )
                        : ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal
                                  .shade700, // Color atractivo para el botón
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
      ),
    );
  }
}
