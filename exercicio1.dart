Future<String> getUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Antonio Manuel Sitoe';
}

void main() async {
  print('Buscando nome do utilizador...');
  String nome = await getUserName();
  print('Nome do utilizador: $nome');
}
