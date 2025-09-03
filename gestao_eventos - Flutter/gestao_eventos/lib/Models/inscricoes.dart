  import 'evento_models.dart';
  import 'utilizador.dart';

  class Inscricao {
    final int Id_Inscricao;
    final DateTime Data_Inscricao;
    final int Id_Estado;
    final int Id_Tipo_Pagamento;
    final int Id_Evento;
    final int Id_Utilizador;

    final Evento? evento;
    final Utilizador? utilizador;

    Inscricao({
      required this.Id_Inscricao,
      required this.Data_Inscricao,
      required this.Id_Estado,
      required this.Id_Tipo_Pagamento,
      required this.Id_Evento,
      required this.Id_Utilizador,
      this.evento,
      this.utilizador,
    });

    factory Inscricao.fromJson(Map<String, dynamic> json) {
      return Inscricao(
        Id_Inscricao: json['Id_Inscricao'],
        Data_Inscricao: DateTime.parse(json['Data_Inscricao']),
        Id_Estado: json['Id_Estado'],
        Id_Tipo_Pagamento: json['Id_Tipo_Pagamento'],
        Id_Evento: json['Id_Evento'],
        Id_Utilizador: json['Id_Utilizador'],
        evento: json['evento'] != null ? Evento.fromJson(json['evento']) : null,
        utilizador: json['utilizador'] != null ? Utilizador.fromJson(json['utilizador']) : null,
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'Id_Inscricao': Id_Inscricao,
        'Data_Inscricao': Data_Inscricao.toIso8601String(),
        'id_Estado': Id_Estado,
        'Id_Tipo_Pagamento': Id_Tipo_Pagamento,
        'Id_Evento': Id_Evento,
        'Id_Utilizador': Id_Utilizador,
      };
    }
  }
