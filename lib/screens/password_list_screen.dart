import 'package:flutter/material.dart';
import 'package:my_project/services/secure_storage.dart';
import 'package:my_project/screens/add_password_screen.dart';
import 'package:my_project/models/password.dart';

class PasswordListScreen extends StatefulWidget {
  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  final SecureStorage _secureStorage = SecureStorage();
  late Future<List<Password>> _passwordsFuture;

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    setState(() {
      _passwordsFuture = _secureStorage.getAllPasswords();
    });
  }

  Future<void> _deletePassword(String id) async {
    await _secureStorage.deletePassword(id);
    _loadPasswords();
  }

  void _showPassword(String password) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
          title: const Text(
            'Contraseña',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          ),
          content: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal, width: 2),
          ),
          child: Text(
            password,
            style: TextStyle(
              fontSize: 18, // Tamaño del texto aumentado
              fontWeight: FontWeight.bold, // Opcional: para hacer el texto en negrita
              color: Colors.black87,
            ),
          ),
        ),
          actions: [
            TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bóveda de contraseñas',
          style: TextStyle(color: Colors.white), // Establece el color del texto a blanco
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: FutureBuilder<List<Password>>(
        future: _passwordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay contraseñas guardadas',style: TextStyle(fontSize: 18, color: Colors.grey)));
          } else {
            final passwords = snapshot.data!;
            return ListView.builder(
              itemCount: passwords.length,
              itemBuilder: (context, index) {
                final password = passwords[index];
                return ListTile(
                  title: Text(password.title),
                  subtitle: Text(password.username),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          _showPassword(password.password);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deletePassword(password.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPasswordScreen()),
          );
          if (result == true) {
            _loadPasswords();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white, // Cambia el color del icono),
      ),
      backgroundColor: Colors.teal,
    ));
  }
}
