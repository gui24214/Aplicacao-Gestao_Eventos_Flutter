import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/utilizador.dart';  
import '../Models/evento_models.dart';
import '../Models/inscricoes.dart';

class ApiService {
  static const bool isProduction = false;

  static final String baseUrl = isProduction
      ? 'https://api.seusite.com/api'
      : 'http://localhost:5294/api';

  // LOGIN
  Future<Utilizador?> login(String email, String passe) async {
    final url = Uri.parse('$baseUrl/Auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'passe': passe}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Utilizador.fromJson(data);
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Falha no login: ${response.statusCode}');
    }
  }

  // CRIAR UTILIZADOR - agora retorna Utilizador? (objeto criado ou null)
  Future<Utilizador?> criarUtilizador(Utilizador utilizador) async {
    final url = Uri.parse('$baseUrl/Utilizador');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(utilizador.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Utilizador.fromJson(data);
    } else {
      print('Erro ao criar utilizador: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  // BUSCAR LISTA DE EVENTOS
  Future<List<Evento>> fetchEventos() async {
    final url = Uri.parse('$baseUrl/Evento');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Evento.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar eventos: ${response.statusCode}');
    }
  }

  // REMOVER EVENTO
  Future<void> deleteEvento(int id) async {
    final url = Uri.parse('$baseUrl/Evento/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao remover evento: ${response.statusCode}');
    }
  }

 Future<void> enviarInscricao({
  required int idEvento,
  required int idUtilizador,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/inscricao'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "Data_Inscricao": DateTime.now().toIso8601String(),
      "Id_Evento": idEvento,
      "Id_Utilizador": idUtilizador,
      // Removido Id_Estado e Id_Tipo_Pagamento para serem opcionais
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Erro ao inscrever: ${response.body}');
  }
}
}
