import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'models/cooking_data.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;

  CookingResultPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: ChatGPTProvider().getCookingInstruction(data),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data!);
        }
      },
    );
  }
}
