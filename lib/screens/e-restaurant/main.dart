import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/categories.dart';
import 'cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasta Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: Categories(),
    );
  }
}
