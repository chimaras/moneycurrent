import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // FlutterToast para notificaciones

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Registro de nuevo usuario
  Future<void> register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _showToast('Usuario registrado correctamente');
      Navigator.pushReplacementNamed(context, '/home'); // Dirigir a pantalla principal (ajusta según tu estructura)
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showToast('La contraseña es muy débil');
      } else if (e.code == 'email-already-in-use') {
        _showToast('El email ya está en uso');
      } else {
        _showToast('Error: ${e.message}');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Inicio de sesión de usuario
  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _showToast('Inicio de sesión exitoso');
      Navigator.pushReplacementNamed(context, '/home'); // Dirigir a pantalla principal
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showToast('No se encontró el usuario');
      } else if (e.code == 'wrong-password') {
        _showToast('Contraseña incorrecta');
      } else {
        _showToast('Error: ${e.message}');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Cerrar sesión de usuario
  Future<void> signOut() async {
    await _auth.signOut();
    _showToast('Sesión cerrada');
    Navigator.pushReplacementNamed(context, '/auth'); // Volver a pantalla de autenticación
  }

  // Mostrar Toast (notificaciones emergentes)
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green, // Color acorde al branding de MoneyCurrent
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autenticación MoneyCurrent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: register,
                        child: Text('Registrar'),
                        style: ElevatedButton.styleFrom(primary: Colors.green), // Botón acorde al branding
                      ),
                      ElevatedButton(
                        onPressed: signIn,
                        child: Text('Iniciar sesión'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
