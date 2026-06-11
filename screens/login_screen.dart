import 'package:flutter/material.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  final User adminUser = User(username: 'admin', password: '123');

  void _login() {
  String inputUser = _userController.text.trim(); 
  String inputPass = _passwordController.text.trim();

  if ((inputUser == 'admin') && inputPass == '123') {
    Navigator.pushReplacementNamed(context, '/products');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario o contraseña incorrectos.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login de Sistema')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
