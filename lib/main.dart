import 'package:flutter/material.dart';
import 'package:reflectiq_designs/screens/finance/main_page.dart';
import 'package:reflectiq_designs/screens/maps_screen.dart';
import 'package:reflectiq_designs/screens/piano.dart';
import 'package:reflectiq_designs/screens/starting_screen.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const Piano());
  }
}
