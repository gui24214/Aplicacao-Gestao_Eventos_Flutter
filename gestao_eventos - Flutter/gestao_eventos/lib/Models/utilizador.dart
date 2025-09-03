class Utilizador {
  final int? idUtilizador;
  final String Nome;
  final String Email;
  final String Telemovel;
  final DateTime Data_Nascimento;
  final String passe;

  Utilizador({
    this.idUtilizador,
    required this.Nome,
    required this.Email,
    required this.Telemovel,
    required this.Data_Nascimento,
    required this.passe,
  });

  factory Utilizador.fromJson(Map<String, dynamic> json) {
    return Utilizador(
      idUtilizador: json['id_Utilizador'],
      Nome: json['nome'] ?? '',
      Email: json['email']?.trim() ?? '',
      Telemovel: json['telemovel'] ?? '',
      Data_Nascimento: DateTime.parse(json['data_Nascimento']),
      passe: json['passe'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        if (idUtilizador != null) 'id_Utilizador': idUtilizador,
        'nome': Nome,
        'email': Email,
        'telemovel': Telemovel,
        'data_Nascimento': Data_Nascimento.toIso8601String(),
        'passe': passe,
      };
}
