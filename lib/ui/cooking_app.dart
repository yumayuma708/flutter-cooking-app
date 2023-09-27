import 'package:caul/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CookingApp extends StatelessWidget {
  const CookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFFEAA4A4);
    return MaterialApp(
      title: 'Cooking As You Like',
      theme: ThemeData(
        useMaterial3: true,
Colors        chemeSeed: seedColor,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
Colors        chemeSeed: seedColor,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
