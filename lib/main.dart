import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: const AuthExample(),
    );
  }
}

class AuthExample extends StatefulWidget {
  const AuthExample({super.key});

  @override
  AuthExampleState createState() => AuthExampleState();
}

class AuthExampleState extends State<AuthExample> {
  String status = "Not signed in";
  String saludo = "";

  /// Login anónimo
  void signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        status = "Signed in anonymously";
      });
    } catch (e) {
      setState(() {
        status = "Error: $e";
      });
    }
  }

  /// Consumir la API http://localhost:3000/saludo
  Future<void> getSaludo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          saludo = "Debes estar autenticado para ver el saludo.";
        });
        return;
      }

      final response = await http.get(Uri.parse("http://10.0.2.2:3000/saludo"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          saludo = data["mensaje"] ?? "Respuesta sin mensaje";
        });
      } else {
        setState(() {
          saludo = "Error al obtener saludo: ${response.statusCode}";
        });
      }

    } catch (e) {
      setState(() {
        saludo = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Auth")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            ElevatedButton(
              onPressed: signInAnonymously,
              child: const Text("Login anónimo"),
            ),
            const SizedBox(height: 20),
            if (user != null) ...[
              ElevatedButton(
                onPressed: getSaludo,
                child: const Text("Obtener saludo"),
              ),
              const SizedBox(height: 10),
              Text(saludo),
            ],
          ],
        ),
      ),
    );
  }
}
