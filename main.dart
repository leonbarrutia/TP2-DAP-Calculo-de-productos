import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/product_entry_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Productos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // Definimos la ruta inicial
      initialRoute: '/',
      // Registramos el Router de la aplicación
      routes: {
        '/': (context) => const LoginScreen(),
        '/products': (context) => const ProductEntryScreen(),
        '/results': (context) => const ResultsScreen(),
      },
    );
  }
}
