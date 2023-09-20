import 'package:caul/ui/cooking_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  OpenAI.apiKey = dotenv.get('API_KEY');
  runApp(
    const ProviderScope(
      child: CookingApp(),
    ),
  );
}
