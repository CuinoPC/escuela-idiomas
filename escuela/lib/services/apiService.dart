import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://escuela-idiomas-backend.onrender.com'; // Cambia la URL según sea necesario

  static Future<String?> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error en la petición GET');
    }
  }

  static Future<String?> post(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en la petición POST');
    }
  }
}
