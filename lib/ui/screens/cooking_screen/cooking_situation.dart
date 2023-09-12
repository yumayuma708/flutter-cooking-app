import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CookingSituation extends ConsumerWidget {
  CookingSituation({Key? key}) : super(key: key);

  final List<String> buttons = [
    '短い時間で',
    '洗い物少なく',
    'お弁当用',
    '筋トレ食',
    '完全食',
    'カロリー少なめ',
    '軽め',
    'がっつり'
  ];

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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 3.0,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      buttons[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          // ここにタブを配置するスペース。具体的なタブの実装は示していません。
          Container(
            height: 50.0,
            color: Colors.orange[200],
            child: Center(child: Text('ここにタブ')),
          )
        ],
      ),
    );
  }
}
