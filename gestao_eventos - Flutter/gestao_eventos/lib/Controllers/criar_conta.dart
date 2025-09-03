import 'package:flutter/material.dart';
import '../Models/utilizador.dart';
import '../Controllers/ecra_utilizador.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ApiService _apiService = ApiService();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  void criarConta() async {
    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        telefoneController.text.isEmpty ||
        dataNascimentoController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    DateTime? dataNascimento;
    try {
      dataNascimento = DateTime.parse(dataNascimentoController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data de nascimento inválida. Use YYYY-MM-DD')),
      );
      return;
    }

    final novoUtilizador = Utilizador(
      Nome: nomeController.text,
      Email: emailController.text,
      Telemovel: telefoneController.text,
      Data_Nascimento: dataNascimento,
      passe: passwordController.text,
    );

    // Aqui esperamos que criarUtilizador retorne o Utilizador criado (com id)
    Utilizador? utilizadorCriado = await _apiService.criarUtilizador(novoUtilizador);

    if (utilizadorCriado != null && utilizadorCriado.idUtilizador != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conta criada com sucesso!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EcranUtilizador(
            nomeUtilizador: utilizadorCriado.Nome,
            idUtilizador: utilizadorCriado.idUtilizador!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar conta. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Color(0xFFF4E4A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(nomeController, 'Nome'),
              SizedBox(height: 15),
              _buildTextField(emailController, 'Email'),
              SizedBox(height: 15),
              _buildTextField(telefoneController, 'Telefone'),
              SizedBox(height: 15),
              TextField(
                controller: dataNascimentoController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Data de Nascimento (YYYY-MM-DD)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    dataNascimentoController.text =
                        pickedDate.toIso8601String().substring(0, 10);
                  }
                },
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
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
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: criarConta,
                child: Text(
                  'Criar Conta',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
