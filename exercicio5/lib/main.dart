import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Formulário Local', home: const FormPage());
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/dados.txt';
  }

  Future<void> _saveToFile() async {
    final name = _nameController.text;
    final email = _emailController.text;

    final content = 'Nome: $name\nEmail: $email\n\n';

    final filePath = await _getFilePath();
    final file = File(filePath);

    await file.writeAsString(content, mode: FileMode.append);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Dados salvos com sucesso!')));

    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveToFile, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
