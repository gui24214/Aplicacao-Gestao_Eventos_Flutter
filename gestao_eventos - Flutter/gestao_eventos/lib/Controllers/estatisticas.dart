import 'package:flutter/material.dart';
import 'evento.dart';
import 'inscricoes.dart';

class EcranEstatisticas extends StatelessWidget {
  const EcranEstatisticas({super.key});

  @override
  Widget build(BuildContext context) {
    final totalEventos = listaEventos.length;
    final totalInscritos = listaInscritos.length;

    return Scaffold(
      appBar: AppBar(title: Text('Estatísticas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total de Eventos: $totalEventos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Total de Inscritos: $totalInscritos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
