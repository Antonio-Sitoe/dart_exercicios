Future<String> comprimentar(String nome) async {
  await Future.delayed(Duration(seconds: 5));
  return '$nome';
}

void main() async {
  print("Comprimenta " + await comprimentar('Antonio'));
}
