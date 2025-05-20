import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

Future<void> salvarNome(String nome) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nome_usuario', nome);
}

Future<String?> obterNome() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('nome_usuario');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo SharedPreferences',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const TelaInserirNome(),
    );
  }
}

class TelaInserirNome extends StatefulWidget {
  const TelaInserirNome({super.key});

  @override
  State<TelaInserirNome> createState() => _TelaInserirNomeState();
}

class _TelaInserirNomeState extends State<TelaInserirNome> {
  final TextEditingController _controller = TextEditingController();

  void _salvarENavegar() async {
    final nome = _controller.text.trim();
    if (nome.isNotEmpty) {
      await salvarNome(nome);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TelaSaudacao()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um nome')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inserir Nome')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Digite seu nome:'),
            const SizedBox(height: 12),
            TextField(controller: _controller),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarENavegar,
              child: const Text('Salvar e Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaSaudacao extends StatelessWidget {
  const TelaSaudacao({super.key});

  Future<String> _carregarNome() async {
    final nome = await obterNome();
    return nome ?? 'usuário';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saudação')),
      body: Center(
        child: FutureBuilder<String>(
          future: _carregarNome(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final nome = snapshot.data ?? 'usuário';
            return Text('Olá, $nome!', style: const TextStyle(fontSize: 24));
          },
        ),
      ),
    );
  }
}
