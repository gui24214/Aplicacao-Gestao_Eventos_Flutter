import 'package:flutter/material.dart';
import 'inscricoes.dart';
import 'estatisticas.dart';
import 'menu_evento.dart';
import 'Login.dart'; // Import necessário para redirecionar ao login

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4E4A1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove o botão "voltar"
        title: Text(
          "Uniconnect",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle, color: Colors.black, size: 30),
            onSelected: (String value) {
              if (value == 'logout') {
                _confirmarLogout(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Terminar Sessão'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _botaoCustomizado(
              context,
              "Eventos",
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenuEvento())),
            ),
            SizedBox(height: 20),
            _botaoCustomizado(
              context,
              "Inscrições",
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => EcranInscricoes())),
            ),
            SizedBox(height: 20),
            _botaoCustomizado(
              context,
              "Estatísticas",
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => EcranEstatisticas())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoCustomizado(BuildContext context, String texto, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6D6D6D),
        minimumSize: Size(350, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  void _confirmarLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text("Tem a certeza que quer terminar sessão?"),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Fecha o diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
