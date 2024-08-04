// lib/screens/add_password_screen.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:my_project/services/secure_storage.dart';
import 'package:my_project/models/password.dart';

class AddPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Clave global para el formulario
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final SecureStorage _secureStorage = SecureStorage();

  AddPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Contraseña'),
        backgroundColor: Colors.teal, // Color de AppBar
        elevation: 4, // Sombra para darle profundidad
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asigna la clave global al formulario
          child: Column(
            children: [
              // Campo para el título
              TextFormField(
                controller: _titleController,
                decoration:  InputDecoration(
                  labelText: 'Titulo',
                  labelStyle: TextStyle(color: Colors.teal),
                   border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor ingrese el titulo'; // Mensaje de error si el campo está vacío
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para el nombre de usuario
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  labelStyle: TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor ingrese el usuario'; // Mensaje de error si el campo está vacío
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para la contraseña
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
                obscureText: true, // Oculta el texto de la contraseña
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor ingrese la contraseña'; // Mensaje de error si el campo está vacío
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { // Valida el formulario
                    var uuid = Uuid();
                    String id = uuid.v4();
                    Password newPassword = Password(
                      id: id,
                      title: _titleController.text,
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );
                    await _secureStorage.savePassword(newPassword);
                    Navigator.pop(context, true); // Regresa a la pantalla anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
