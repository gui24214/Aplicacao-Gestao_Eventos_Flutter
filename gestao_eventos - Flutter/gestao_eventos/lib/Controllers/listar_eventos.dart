import 'package:flutter/material.dart';
import '../Models/evento_models.dart';
import '../services/api_service.dart';
import 'editar_evento.dart';

class ListarEventos extends StatefulWidget {
  const ListarEventos({Key? key}) : super(key: key);

  @override
  _ListarEventosState createState() => _ListarEventosState();
}

class _ListarEventosState extends State<ListarEventos> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  List<Evento> todosEventos = [];
  List<Evento> eventosFiltrados = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _carregarEventos();
    _searchController.addListener(_filtrarEventos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _carregarEventos() async {
    try {
      final eventos = await _apiService.fetchEventos();
      setState(() {
        todosEventos = eventos;
        eventosFiltrados = eventos;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void _filtrarEventos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      eventosFiltrados = todosEventos.where((evento) {
        return evento.nome.toLowerCase().contains(query);
      }).toList();
    });
  }

  String formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  void _removerEvento(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover Evento'),
        content: Text('Tem certeza que deseja remover este evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Fecha o diálogo

              final eventoRemovido = eventosFiltrados[index];

              setState(() {
                isLoading = true; // Mostra loading enquanto remove
              });

              try {
                await _apiService.deleteEvento(eventoRemovido.id);

                setState(() {
                  todosEventos.remove(eventoRemovido);
                  eventosFiltrados.removeAt(index);
                  isLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Evento removido com sucesso!')),
                );
              } catch (e) {
                setState(() {
                  isLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao remover evento: $e')),
                );
              }
            },
            child: Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Eventos'),
        backgroundColor: Color(0xFF6D6D6D),
      ),
      backgroundColor: Color(0xFFF4E4A1),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text('Erro ao carregar eventos.'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Pesquisar por nome do evento',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: eventosFiltrados.isEmpty
                          ? Center(
                              child: Text(
                                'Nenhum evento encontrado.',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(12),
                              itemCount: eventosFiltrados.length,
                              itemBuilder: (context, index) {
                                final evento = eventosFiltrados[index];
                                return Card(
                                  margin: EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.redAccent),
                                              tooltip: 'Remover Evento',
                                              onPressed: () =>
                                                  _removerEvento(index),
                                            ),
                                            SizedBox(width: 8),
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Colors.orangeAccent),
                                              tooltip: 'Editar Evento',
                                              onPressed: () async {
                                                final eventoAtualizado =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AtualizarEvento(
                                                            evento: evento),
                                                  ),
                                                );
                                                if (eventoAtualizado != null &&
                                                    eventoAtualizado
                                                        is Evento) {
                                                  setState(() {
                                                    final idx =
                                                        todosEventos.indexWhere(
                                                            (e) =>
                                                                e.id ==
                                                                evento.id);
                                                    if (idx != -1) {
                                                      todosEventos[idx] =
                                                          eventoAtualizado;
                                                      _filtrarEventos();
                                                    }
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          evento.nome,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text('Data: ${formatarData(evento.data)}'),
                                        Text('Hora Início: ${evento.horaInicio}'),
                                        Text('Hora Fim: ${evento.horaFim}'),
                                        Text('Capacidade Máxima: ${evento.capacidadeMaxima}'),
                                        Text('Tipo de Evento: ${evento.tipoEvento}'),
                                        Text('Despesas: ${evento.despesas}'),
                                        Text('Localização: ${evento.localizacao}'),
                                        Text('Valor do Pagamento: R\$ ${evento.valorPagamento.toStringAsFixed(2)}'),
                                      ],
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
