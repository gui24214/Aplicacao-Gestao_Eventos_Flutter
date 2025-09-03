import 'package:flutter/material.dart';
import '../Controllers/Menu_principal.dart';
import '../Controllers/ecra_utilizador.dart';
import 'criar_conta.dart';
import '../Models/utilizador.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  void fazerLogin() async {
    final email = emailController.text.trim();
    final passe = passwordController.text.trim();

    if (email.isEmpty || passe.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha email e senha')),
      );
      return;
    }

    try {
      final api = ApiService();
      final user = await api.login(email, passe);

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ou senha incorretos')),
        );
      } else {
        final userEmail = user.Email.trim().toLowerCase();
        final isAdmin = user.Email.trim().toLowerCase() == 'admin@gmail.com';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isAdmin ? 'Login como Administrador!' : 'Login como Utilizador!',
            ),
          ),
        );

        // Redirecionamento separado
        if (isAdmin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuPrincipal()),
          );
        } else {
          // Passa o id e o nome do utilizador para o ecrã de utilizador
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EcranUtilizador(
                nomeUtilizador: user.Nome,
                 idUtilizador: user.idUtilizador!,
              ),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar com o servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4E4A1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: fazerLogin,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'CRIAR CONTA',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
