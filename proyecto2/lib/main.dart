import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pantallaInicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beast Gamer Training',
      theme: ThemeData(
        fontFamily: 'SonicFont',
        scaffoldBackgroundColor: Color.fromARGB(255, 22, 127, 246), 
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 15, 179, 204)),
         textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    headline1: TextStyle(color: Colors.blue), 
  ),
        useMaterial3: true,
      ),
      home: const 
      MyHomePage(title: 'Beast Gamer Training'),
      
    );
  }
}
