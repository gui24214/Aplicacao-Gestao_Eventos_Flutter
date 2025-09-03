import 'package:flutter/material.dart';
import 'evento.dart';
import 'listar_eventos.dart';

class MenuEvento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4E4A1),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Gestão de Eventos"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _botao(context, "Criar Evento", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EcranEventos()),
              );
            }),
            SizedBox(height: 20),
            _botao(context, "Listar Eventos", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListarEventos(), // sem passar lista
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _botao(BuildContext context, String texto, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6D6D6D),
        minimumSize: Size(300, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
