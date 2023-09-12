import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CookingSituation extends ConsumerWidget {
  const CookingSituation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          '条件を選ぶ',
          style: TextStyle(color: Colors.black, fontSize: 35),
        ),
      ),
      body: const Center(
          child: Text(
        'ここに作る',
        style: TextStyle(fontSize: 30), // ボディ部分を変更
      )),
    );
  }
}
