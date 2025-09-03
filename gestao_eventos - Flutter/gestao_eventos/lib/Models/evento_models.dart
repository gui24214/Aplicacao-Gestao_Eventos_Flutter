class Evento {
  final int id;
  final String nome;
  final DateTime data;
  final String horaInicio;
  final String horaFim;
  final int capacidadeMaxima;
  final String tipoEvento;
  final String despesas;
  final String localizacao;
  final double valorPagamento;

  Evento({
    required this.id,
    required this.nome,
    required this.data,
    required this.horaInicio,
    required this.horaFim,
    required this.capacidadeMaxima,
    required this.tipoEvento,
    required this.despesas,
    required this.localizacao,
    required this.valorPagamento,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id_Evento'] ?? json['Id_Evento'] ?? 0,
      nome: json['nome'] ?? json['Nome'] ?? '',
      data: DateTime.parse(json['data'] ?? json['Data']),
      horaInicio: json['hora_Inicio'] ?? json['Hora_Inicio'] ?? '',
      horaFim: json['hora_Fim'] ?? json['Hora_Fim'] ?? '',
      capacidadeMaxima: json['capacidade_Maxima'] ?? json['Capacidade_Maxima'] ?? 0,
      tipoEvento: json['tipoEvento'] ?? json['Tipo_Evento']?['nome'] ?? '',
      despesas: json['despesas'] ?? '',
      localizacao: json['localizacao'] ?? '',
      valorPagamento: (json['valorPagamento'] ?? 0).toDouble(),
    );
  }
}
