import 'package:flutter/material.dart';
import 'package:reflectiq_designs/screens/change_color.dart';
import 'package:reflectiq_designs/screens/finetech/home.dart';
import 'package:reflectiq_designs/screens/finetech/login.dart';
import 'package:reflectiq_designs/screens/finetech/splash_screen.dart';

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
        home: const ChangeColor());
  }
}
