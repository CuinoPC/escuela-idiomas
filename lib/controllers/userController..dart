import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:escuela/models/user.dart';

class UserController {
  final String baseUrl =
      'https://escuela-idiomas-backend.onrender.com/api/users'; // Cambiar por la URL de tu servidor

  // Enviar la solicitud de login al backend
  Future<Map<String, dynamic>?> loginUser(
      String matricula, String password) async {
    final response = await http.post(
      Uri.parse('https://escuela-idiomas-backend.onrender.com/api/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'matricula': matricula, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['user'];
    } else {
      // Imprime el cuerpo de la respuesta de error para ayudar a depurar
      print('Error en el login: ${response.body}');
      throw Exception('Error en el login: ${response.body}');
    }
  }

  // Obtener todos los usuarios
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  // Crear un nuevo usuario
  Future<void> createUser(
      String matricula, String name, String role, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'), // Endpoint para registrar el usuario
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'matricula': matricula,
        'name': name,
        'role': role,
        'password':
            password, // Incluir la contraseña en el cuerpo de la solicitud
      }),
    );

    if (response.statusCode == 201) {
      print('Usuario creado exitosamente');
    } else {
      throw Exception('Error al registrar el usuario: ${response.body}');
    }
  }

  // Modificar un usuario
  Future<void> updateUser(String matricula, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$matricula'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el usuario');
    }
  }

  // Eliminar un usuario
  Future<void> deleteUser(String matricula) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$matricula'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }
}
