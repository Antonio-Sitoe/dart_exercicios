Future<void> buscarProdutor(String nome) async {
  await Future.delayed(Duration(seconds: 5));

  if (nome == "PC") {
    print("PRODUTO ENCONTRADO");
  } else {
    throw Exception("Erro ao buscar produto");
  }
}

void main() async {
  print("Pesquisa o produto");
  try {
    await buscarProdutor("CAMISOLA");
  } catch (e) {
    print(e.toString());
  }
}
