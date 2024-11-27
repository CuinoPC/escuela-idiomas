// user.dart

class User {
  final String matricula;
  final String name;
  final String role;
  final String password; // Añadido el campo password

  User({
    required this.matricula,
    required this.name,
    required this.role,
    required this.password, // Asegúrate de pasar la contraseña al crear el usuario
  });

  // Método para crear un objeto User desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      matricula: json['matricula'],
      name: json['name'],
      role: json['role'],
      password: json[
          'password'], // Asumiendo que el backend también devuelve la contraseña (aunque no es una buena práctica)
    );
  }

  // Método para convertir un User a JSON para enviarlo al servidor
  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'name': name,
      'role': role,
      'password': password, // Incluye la contraseña en el JSON
    };
  }
}
