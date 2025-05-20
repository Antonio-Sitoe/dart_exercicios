Future<String> primeiroCarregamento() async {
  await Future.delayed(Duration(seconds: 2));
  return '1 carregamento';
}

Future<String> segundoCarregamento() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Primeiro carregamento';
}

Future<String> terceitoCarregamento() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Terceiro carregamento';
}

void main() async {
  print("OLa vamos carregar");
  print(await primeiroCarregamento());
  print(await segundoCarregamento());
  print(await terceitoCarregamento());
}
