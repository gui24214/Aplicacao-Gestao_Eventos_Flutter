  // controllers/user_controller.dart
class User {
  final String nome;
  final String email;
  final String telefone;
  final String dataNascimento;
  final String password;

  User({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.password,
  });
}

List<User> userList = [];

bool registerUser(User user) {
  bool exists = userList.any((u) => u.email == user.email);
  if (!exists) {
    userList.add(user);
    return true;
  }
  return false;
}

bool loginUser(String email, String password) {
  return userList.any((u) => u.email == email && u.password == password);
}
