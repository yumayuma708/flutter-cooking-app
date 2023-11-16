import 'package:flutter/material.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリを共有'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // アプリを共有するための処理を実装する
          },
          child: const Text('アプリを共有する'),
        ),
      ),
    );
  }
}
