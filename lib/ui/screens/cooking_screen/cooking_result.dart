import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;

  const CookingResultPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: ChatGPTProvider().getCookingInstruction(data),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Text(snapshot.data ?? "No data found"),
              );
            }
          },
        ),
      ),
    );
  }
}
