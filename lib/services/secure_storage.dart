import 'dart:convert'; // Para la conversión JSON
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_project/models/password.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Guarda una contraseña en el almacenamiento seguro.
  Future<void> savePassword(Password password) async {
    // Convierte el objeto Password a un mapa y luego a una cadena JSON.
    String passwordJson = jsonEncode(password.toMap());
    await _storage.write(
      key: password.id,
      value: passwordJson,
    );
  }

  /// Recupera una contraseña del almacenamiento seguro utilizando su ID.
  Future<Password?> getPassword(String id) async {
    // Lee la cadena JSON del almacenamiento.
    String? data = await _storage.read(key: id);
    if (data != null) {
      // Convierte la cadena JSON a un mapa.
      Map<String, dynamic> map = jsonDecode(data);
      // Crea y retorna un objeto Password desde el mapa.
      return Password.fromMap(Map<String, String>.from(map));
    }
    return null; // Retorna null si no se encontró la contraseña.
  }

  /// Elimina una contraseña del almacenamiento seguro utilizando su ID.
  Future<void> deletePassword(String id) async {
    await _storage.delete(key: id);
  }

  /// Recupera todas las contraseñas del almacenamiento seguro.
  Future<List<Password>> getAllPasswords() async {
  try {
    Map<String, String> allData = await _storage.readAll();
    return allData.entries.map((entry) {
      Map<String, dynamic> map = jsonDecode(entry.value);
      return Password.fromMap(Map<String, String>.from(map));
    }).toList();
  } catch (e) {
    return [];
  }
}

}
