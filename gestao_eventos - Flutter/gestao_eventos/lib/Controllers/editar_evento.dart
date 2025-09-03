import 'package:flutter/material.dart';
import '../Models/evento_models.dart';

class AtualizarEvento extends StatefulWidget {
  final Evento evento;

  const AtualizarEvento({Key? key, required this.evento}) : super(key: key);

  @override
  _AtualizarEventoState createState() => _AtualizarEventoState();
}

class _AtualizarEventoState extends State<AtualizarEvento> {
  late TextEditingController nomeController;
  late TextEditingController capacidadeController;
  late TextEditingController despesasController;
  late TextEditingController localizacaoController;
  late TextEditingController valorPagamentoController;

  late DateTime dataSelecionada;
  late TimeOfDay horaInicioSelecionada;
  late TimeOfDay horaFimSelecionada;
  late String tipoEventoSelecionado;

  final List<String> tiposEvento = [
    'Palestra',
    'Workshop',
    'Conferência',
    'Seminário',
    'Treinamento',
  ];

  @override
  void initState() {
    super.initState();
    final evento = widget.evento;
    nomeController = TextEditingController(text: evento.nome);
    capacidadeController = TextEditingController(text: evento.capacidadeMaxima.toString());
    despesasController = TextEditingController(text: evento.despesas);
    localizacaoController = TextEditingController(text: evento.localizacao);
    valorPagamentoController = TextEditingController(text: evento.valorPagamento.toString());

    dataSelecionada = evento.data;
    horaInicioSelecionada = _converterHora(evento.horaInicio);
    horaFimSelecionada = _converterHora(evento.horaFim);
    tipoEventoSelecionado = evento.tipoEvento;
  }

  TimeOfDay _converterHora(String hora) {
    final partes = hora.split(':');
    return TimeOfDay(hour: int.parse(partes[0]), minute: int.parse(partes[1]));
  }

  String _formatarHora(TimeOfDay hora) {
    final horaStr = hora.hour.toString().padLeft(2, '0');
    final minutoStr = hora.minute.toString().padLeft(2, '0');
    return '$horaStr:$minutoStr';
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Future<void> _selecionarData() async {
    final hoje = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: hoje,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6D6D6D),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Color(0xFFF4E4A1),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dataSelecionada = picked;
      });
    }
  }

  Future<void> _selecionarHoraInicio() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: horaInicioSelecionada,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        horaInicioSelecionada = picked;
      });
    }
  }

  Future<void> _selecionarHoraFim() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: horaFimSelecionada,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        horaFimSelecionada = picked;
      });
    }
  }

  void _guardarAlteracoes() {
    if (nomeController.text.trim().isEmpty ||
        capacidadeController.text.trim().isEmpty ||
        despesasController.text.trim().isEmpty ||
        localizacaoController.text.trim().isEmpty ||
        valorPagamentoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    final eventoAtualizado = Evento(
      id: widget.evento.id,
      nome: nomeController.text,
      data: dataSelecionada,
      horaInicio: _formatarHora(horaInicioSelecionada),
      horaFim: _formatarHora(horaFimSelecionada),
      capacidadeMaxima: int.parse(capacidadeController.text),
      tipoEvento: tipoEventoSelecionado,
      despesas: despesasController.text,
      localizacao: localizacaoController.text,
      valorPagamento: double.parse(valorPagamentoController.text),
    );

    Navigator.pop(context, eventoAtualizado);
  }

  Widget _campoTexto(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _campoSelecaoData() {
    return GestureDetector(
      onTap: _selecionarData,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Data do Evento',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            Text(
              _formatarData(dataSelecionada),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoSelecaoHora(String label, String textoExibido, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            Text(
              textoExibido,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4E4A1),
      appBar: AppBar(
        title: Text('Atualizar Evento'),
        backgroundColor: Color(0xFF6D6D6D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _campoTexto('Nome do Evento', nomeController),
            _campoSelecaoData(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _campoSelecaoHora(
                    'Hora Início',
                    _formatarHora(horaInicioSelecionada),
                    _selecionarHoraInicio,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _campoSelecaoHora(
                    'Hora Fim',
                    _formatarHora(horaFimSelecionada),
                    _selecionarHoraFim,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: _campoTexto('Capacidade Máxima', capacidadeController, isNumeric: true),
                ),
              ],
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: tipoEventoSelecionado,
              decoration: InputDecoration(
                labelText: 'Tipo de Evento',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: tiposEvento.map((tipo) => DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  )).toList(),
              onChanged: (valor) {
                setState(() {
                  tipoEventoSelecionado = valor!;
                });
              },
            ),
            SizedBox(height: 15),
            _campoTexto('Despesas', despesasController),
            _campoTexto('Localização', localizacaoController),
            _campoTexto('Valor do Pagamento', valorPagamentoController, isNumeric: true),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _guardarAlteracoes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D6D6D),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Guardar Alterações',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
