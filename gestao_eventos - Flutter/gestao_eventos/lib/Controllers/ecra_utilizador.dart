import 'package:flutter/material.dart';
import '../Models/evento_models.dart';
import '../Models/inscricoes.dart';
import '../services/api_service.dart';

List<Inscricao> listaInscricoes = [];

class EcranUtilizador extends StatefulWidget {
  final String nomeUtilizador;
  final int idUtilizador;

  EcranUtilizador({
    required this.nomeUtilizador,
    required this.idUtilizador,
  });

  @override
  _EcranUtilizadorState createState() => _EcranUtilizadorState();
}

class _EcranUtilizadorState extends State<EcranUtilizador> {
  final ApiService _apiService = ApiService();
  List<Evento> _todosEventos = [];
  List<Evento> _eventosFiltrados = [];
  int? eventoSelecionado;
  String _filtroNome = '';
  late final TextEditingController _nomeController;

  @override
  void initState() {
    super.initState();
    carregarEventos();
    _nomeController = TextEditingController(text: widget.nomeUtilizador);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> carregarEventos() async {
    try {
      List<Evento> eventos = await _apiService.fetchEventos();
      setState(() {
        _todosEventos = eventos;
        _eventosFiltrados = eventos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar eventos')),
      );
    }
  }

  void aplicarFiltro(String valor) {
    setState(() {
      _filtroNome = valor;
      _eventosFiltrados = _todosEventos
          .where((e) => e.nome.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    });
  }

  void inscreverNoEvento() async {
    if (eventoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione um evento.')),
      );
      return;
    }

    // ✅ Verifica se já existe inscrição
    if (listaInscricoes.any((i) =>
        i.Id_Evento == eventoSelecionado &&
        i.Id_Utilizador == widget.idUtilizador)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você já está inscrito neste evento.')),
      );
      return;
    }

    try {
      await _apiService.enviarInscricao(
        idEvento: eventoSelecionado!,
        idUtilizador: widget.idUtilizador,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscrição realizada com sucesso!')),
      );

      setState(() {
        eventoSelecionado = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar inscrição: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Área do Utilizador'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Color(0xFFF4E4A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Inscreva-se num Evento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Campo de busca
              TextField(
                decoration: InputDecoration(
                  labelText: 'Pesquisar Evento por Nome',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: aplicarFiltro,
              ),
              SizedBox(height: 15),

              // ✅ LayoutBuilder para evitar overflow + formatação do texto
              LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Selecione um Evento',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      value: eventoSelecionado,
                      items: _eventosFiltrados.map((evento) {
                        final dataFormatada =
                            '${evento.data.day}/${evento.data.month}/${evento.data.year}';
                        return DropdownMenuItem(
                          value: evento.id,
                          child: Text(
                            '${evento.nome} - $dataFormatada',
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          eventoSelecionado = val;
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 15),

              // Nome do utilizador (read-only)
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Seu Nome',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                readOnly: true,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: inscreverNoEvento,
                child: Text(
                  'Inscrever',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),

              SizedBox(height: 30),
              Divider(),

              Text(
                'Seus Eventos Inscritos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: listaInscricoes
                    .where((inscricao) =>
                        inscricao.Id_Utilizador == widget.idUtilizador)
                    .map((inscricao) {
                  final evento = _todosEventos.firstWhere(
                    (e) => e.id == inscricao.Id_Evento,
                    orElse: () => Evento(
                      id: 0,
                      nome: 'Desconhecido',
                      data: DateTime.now(),
                      tipoEvento: '',
                      horaInicio: '',
                      horaFim: '',
                      capacidadeMaxima: 0,
                      despesas: '',
                      localizacao: '',
                      valorPagamento: 0.0,
                    ),
                  );

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(evento.nome),
                      subtitle: Text(
                          'Data: ${evento.data.day}/${evento.data.month}/${evento.data.year} | Tipo: ${evento.tipoEvento}'),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
