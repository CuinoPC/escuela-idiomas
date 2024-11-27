import 'package:escuela/screens/loginAdminScreen.dart';
import 'package:escuela/screens/loginAlumnoScreen.dart';
import 'package:escuela/screens/loginProfessorScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecciona tu Rol',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto', // Fuente más moderna
          ),
        ),
        centerTitle: true, // Centra el título en la AppBar
        backgroundColor: Colors.teal, // Color de fondo más atractivo
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.marista.edu.mx/files/media/image/element_e5d151c944dfa8fcca89f4e1d45ac474.jpg'),
            fit: BoxFit.cover, // Asegura que la imagen cubra toda la pantalla
            colorFilter: ColorFilter.mode(
              Colors.black
                  .withOpacity(0.3), // Aplica un filtro oscuro a la imagen
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra todo el contenido
            children: [
              Text(
                'Por favor, selecciona tu rol para iniciar sesión:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Color blanco para el texto
                ),
              ),
              SizedBox(height: 30), // Espacio entre el texto y los botones
              GridView.count(
                shrinkWrap:
                    true, // Hace que el GridView ocupe solo el espacio necesario
                crossAxisCount: 3, // 3 columnas para los cuadros
                crossAxisSpacing: 20, // Espacio horizontal entre los cuadros
                mainAxisSpacing: 20, // Espacio vertical entre los cuadros
                childAspectRatio:
                    2, // Ajusta la relación de aspecto de los cuadros
                children: [
                  _buildRoleCard(context, 'Admin', LoginAdminScreen()),
                  _buildRoleCard(context, 'Alumno', LoginAlumnoScreen()),
                  _buildRoleCard(context, 'Profesor', LoginProfesorScreen()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String role, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        color: Colors.white.withOpacity(0.7), // Cuadro con mayor opacidad
        elevation: 10, // Aumenta la sombra para un efecto más pronunciado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes más redondeados
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Login de $role',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal, // Color que destaca para el texto
              ),
              textAlign: TextAlign.center, // Centra el texto dentro del cuadro
            ),
          ),
        ),
      ),
    );
  }
}
