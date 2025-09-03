import 'package:flutter/material.dart';
import '../Models/evento_models.dart';
import '../Models/evento_atualizado.dart';  // Importa listaEventosGlobais

class Inscrito {
  final String nome;
  final int idEvento;
  bool confirmado;

  Inscrito({
    required this.nome,
    required this.idEvento,
    this.confirmado = false,
  });
}

List<Inscrito> listaInscritos = [];

class EcranInscricoes extends StatefulWidget {
  const EcranInscricoes({super.key});

  @override
  State<EcranInscricoes> createState() => _EcranInscricoesState();
}

class _EcranInscricoesState extends State<EcranInscricoes> {
  final pesquisaController = TextEditingController();
  List<Evento> eventosFiltrados = [];

  @override
  void initState() {
    super.initState();
    eventosFiltrados = List.from(listaEventosGlobais);
    pesquisaController.addListener(_filtrarEventos);
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  void _filtrarEventos() {
    final query = pesquisaController.text.toLowerCase();
    setState(() {
      eventosFiltrados = listaEventosGlobais.where((evento) {
        return evento.nome.toLowerCase().contains(query);
      }).toList();
    });
  }

  String formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Inscrições'),
        backgroundColor: const Color(0xFF6D6D6D),
      ),
      backgroundColor: const Color(0xFFF4E4A1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: pesquisaController,
              decoration: const InputDecoration(
                labelText: 'Pesquisar evento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: eventosFiltrados.isEmpty
                ? const Center(child: Text('Nenhum evento encontrado.'))
                : ListView.builder(
                    itemCount: eventosFiltrados.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemBuilder: (context, index) {
                      final evento = eventosFiltrados[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            evento.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Data: ${formatarData(evento.data)}'),
                              Text('Hora Início: ${evento.horaInicio}'),
                              Text('Hora Fim: ${evento.horaFim}'),
                              Text('Capacidade: ${evento.capacidadeMaxima}'),
                              Text('Tipo: ${evento.tipoEvento}'),
                              Text('Despesas: ${evento.despesas}'),
                              Text('Localização: ${evento.localizacao}'),
                              Text('Valor: R\$ ${evento.valorPagamento.toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Ação ao clicar em Ver, ex: navegar para detalhes
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade800,
                            ),
                            child: const Text('Ver'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
