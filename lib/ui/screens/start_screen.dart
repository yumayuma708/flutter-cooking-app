import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('おたすけCook！にログイン'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'メールアドレス',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'パスワード',
            ),
          ),
          SizedBox(height: 16),
          Text(
            'このアプリの利用を開始することで、利用規約及びプライバシーポリシーに同意したものとみなします。',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
