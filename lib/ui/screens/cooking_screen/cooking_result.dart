import 'package:caul/ui/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;

  const CookingResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(data.instruction),
        ),
      ),
    );
  }
}
