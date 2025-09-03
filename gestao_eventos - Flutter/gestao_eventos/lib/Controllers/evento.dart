  import 'package:flutter/material.dart';
  import '../Models/evento_models.dart'; // ✅ Importa a classe Evento corretamente

  // Lista global de eventos (pode ser movida para um provider mais tarde, se quiser)
  List<Evento> listaEventos = [];

  class EcranEventos extends StatefulWidget {
    const EcranEventos({Key? key}) : super(key: key);

    @override
    _EcranEventosState createState() => _EcranEventosState();
  }

  class _EcranEventosState extends State<EcranEventos> {
    final nomeController = TextEditingController();
    DateTime? dataSelecionada;
    final capacidadeController = TextEditingController();
    final despesasController = TextEditingController();
    final localizacaoController = TextEditingController();
    final valorPagamentoController = TextEditingController();

    TimeOfDay? horaInicioSelecionada;
    TimeOfDay? horaFimSelecionada;

    String tipoEventoSelecionado = 'Palestra';

    final List<String> tiposEvento = [
      'Palestra',
      'Workshop',
      'Conferência',
      'Seminário',
      'Treinamento'
    ];

    Future<void> _selecionarData() async {
      final hoje = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: dataSelecionada ?? hoje,
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
        initialTime: horaInicioSelecionada ?? TimeOfDay.now(),
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
        initialTime: horaFimSelecionada ?? TimeOfDay.now(),
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

    String formatarData(DateTime? data) {
      if (data == null) return 'Selecione a data';
      return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
    }

    String formatarHora24h(TimeOfDay? hora) {
      if (hora == null) return 'Selecionar';
      final horaStr = hora.hour.toString().padLeft(2, '0');
      final minutoStr = hora.minute.toString().padLeft(2, '0');
      return '$horaStr:$minutoStr';
    }

    void adicionarEvento() {
      if (nomeController.text.trim().isEmpty ||
          dataSelecionada == null ||
          horaInicioSelecionada == null ||
          horaFimSelecionada == null ||
          capacidadeController.text.trim().isEmpty ||
          despesasController.text.trim().isEmpty ||
          localizacaoController.text.trim().isEmpty ||
          valorPagamentoController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, preencha todos os campos.')),
        );
        return;
      }

      setState(() {
        final novoEvento = Evento(
          id: DateTime.now().millisecondsSinceEpoch,
          nome: nomeController.text,
          data: dataSelecionada!,
          horaInicio: formatarHora24h(horaInicioSelecionada),
          horaFim: formatarHora24h(horaFimSelecionada),
          capacidadeMaxima: int.parse(capacidadeController.text),
          tipoEvento: tipoEventoSelecionado,
          despesas: despesasController.text,
          localizacao: localizacaoController.text,
          valorPagamento: double.parse(valorPagamentoController.text),
        );

        listaEventos.add(novoEvento);

        nomeController.clear();
        dataSelecionada = null;
        horaInicioSelecionada = null;
        horaFimSelecionada = null;
        capacidadeController.clear();
        despesasController.clear();
        localizacaoController.clear();
        valorPagamentoController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Evento adicionado com sucesso!')),
      );
    }

    Widget _campoTexto(String label, TextEditingController controller,
        {bool isNumeric = false}) {
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
                formatarData(dataSelecionada),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    Widget _campoSelecaoHora(
        String label, String textoExibido, VoidCallback onTap) {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Gestão de Eventos',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
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
                      formatarHora24h(horaInicioSelecionada),
                      _selecionarHoraInicio,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: _campoSelecaoHora(
                      'Hora Fim',
                      formatarHora24h(horaFimSelecionada),
                      _selecionarHoraFim,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: _campoTexto(
                      'Capacidade Máxima',
                      capacidadeController,
                      isNumeric: true,
                    ),
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
                items: tiposEvento
                    .map((tipo) => DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (valor) {
                  setState(() {
                    tipoEventoSelecionado = valor!;
                  });
                },
              ),
              SizedBox(height: 15),
              _campoTexto('Despesas', despesasController),
              _campoTexto('Localização', localizacaoController),
              _campoTexto('Valor do Pagamento', valorPagamentoController,
                  isNumeric: true),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: adicionarEvento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D6D6D),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Adicionar Evento',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
