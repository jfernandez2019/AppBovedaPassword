import 'dart:convert';

class Password {
  final String id;
  final String title;
  final String username;
  final String password;

  Password({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
  });

  // Convierte a Map para almacenar en JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'password': password,
    };
  }

  // Crea una instancia de Password a partir de un Map
  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map['id'] as String,
      title: map['title'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}


