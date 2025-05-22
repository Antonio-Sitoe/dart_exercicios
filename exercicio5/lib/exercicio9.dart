import 'package:exercicio5/product.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _productsFuture = [] as Future<List<Product>>;

  Future<List<Product>> _loadProducts() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Product.fromJson(item)).toList();
  }

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ListTile(
                  onTap: () {
                    final snackBar = SnackBar(content: Text(p.name));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  title: Text(p.name),
                  subtitle: Text('ID: ${p.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
