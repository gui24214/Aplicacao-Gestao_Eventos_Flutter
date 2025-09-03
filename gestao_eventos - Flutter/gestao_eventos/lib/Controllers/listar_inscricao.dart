import 'package:flutter/material.dart';
import '../Models/evento_models.dart';
import 'inscricoes.dart'; // para acessar listaInscritos e Inscrito

class ListarInscricao extends StatefulWidget {
  final Evento evento;

  const ListarInscricao({Key? key, required this.evento}) : super(key: key);

  @override
  _ListarInscricaoState createState() => _ListarInscricaoState();
}

class _ListarInscricaoState extends State<ListarInscricao> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<Inscrito> _inscritosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _pesquisaController.addListener(_filtrarInscritos);
    _filtrarInscritos(); // inicializa com todos os inscritos do evento
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  void _filtrarInscritos() {
    final query = _pesquisaController.text.toLowerCase();
    setState(() {
      _inscritosFiltrados = listaInscritos
          .where((i) =>
              i.idEvento == widget.evento.id &&
              i.nome.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscritos - ${widget.evento.nome}'),
        backgroundColor: Color(0xFF6D6D6D),
      ),
      backgroundColor: Color(0xFFF4E4A1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pesquisaController,
              decoration: InputDecoration(
                labelText: 'Pesquisar inscrito',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _inscritosFiltrados.isEmpty
                  ? Center(child: Text('Nenhum inscrito encontrado.'))
                  : ListView.builder(
                      itemCount: _inscritosFiltrados.length,
                      itemBuilder: (context, index) {
                        final inscrito = _inscritosFiltrados[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              inscrito.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(inscrito.confirmado
                                ? 'Confirmado'
                                : 'Não confirmado'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
