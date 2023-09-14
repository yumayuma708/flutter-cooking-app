import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;

  const CookingResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          title: const Text(
            'AIの考えたレシピ',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [Text(data.instruction)],
            ),
          ),
        ));
  }
}
