import 'package:flutter/material.dart';
import 'package:reflectiq_designs/screens/e-restaurant/categories.dart';
import 'package:reflectiq_designs/screens/finance/main_page.dart';
import 'package:reflectiq_designs/screens/pedro_pedro.dart';
import 'package:reflectiq_designs/screens/piano.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const PedroPedroTrend());
  }
}
