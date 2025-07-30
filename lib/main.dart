import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      title: 'Formulario Firebase App',
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();
  final _correoController = TextEditingController();
  final _passController = TextEditingController();

  bool isLogin = true;
  String mensaje = "";

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        // Login
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _correoController.text.trim(),
            password: _passController.text.trim(),
          );
          setState(() {
            mensaje = "¡Bienvenido ${_nombreController.text}!";
          });
        } catch (e) {
          setState(() {
            mensaje = "Error al iniciar sesión: $e";
          });
        }
      } else {
        // Registro
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _correoController.text.trim(),
            password: _passController.text.trim(),
          );
          setState(() {
            mensaje = "Usuario registrado: ${_correoController.text}";
          });
        } catch (e) {
          setState(() {
            mensaje = "Error al registrarse: $e";
          });
        }
      }

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Datos Ingresados'),
          content: Text(
              'Nombre: ${_nombreController.text}\nEdad: ${_edadController.text}\nCorreo: ${_correoController.text}\n\n$mensaje'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulario + Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (user == null) Form(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _edadController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Edad'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        final edad = int.tryParse(value);
                        if (edad == null || edad <= 0) {
                          return 'Debe ser un número mayor a 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _correoController,
                      decoration: const InputDecoration(labelText: 'Correo'),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                          return 'Correo inválido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? '¿No tienes cuenta? Regístrate'
                          : '¿Ya tienes cuenta? Inicia sesión'),
                    ),
                  ],
                ),
              ),
            )
            else
              Column(
                children: [
                  Text("Bienvenido ${user.email}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {});
                    },
                    child: const Text("Cerrar sesión"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
