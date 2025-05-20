import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> salvarNome(String nome) async {
  final preferenceInstance = await SharedPreferences.getInstance();
  await preferenceInstance.setString("name", nome);
}

Future<String?> obterNome() async {
  final preferenceInstance = await SharedPreferences.getInstance();
  final name = await preferenceInstance.getString("name");
  return name;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(controller: name),
              OutlinedButton(
                onPressed: () {
                  salvarNome(name.text);
                },
                child: Text('Submeter'),
              ),
              OutlinedButton(
                onPressed: () async {
                  final nomeSalvo = await obterNome();
                  if (nomeSalvo != null) {
                    setState(() {
                      name.text = nomeSalvo;
                    });
                  }
                },
                child: Text('Obter nome'),
              ),
              Text(name.value.text),
            ],
          ),
        ),
      ),
    );
  }
}
