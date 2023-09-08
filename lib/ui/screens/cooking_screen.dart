import 'package:flutter/material.dart';

class CookingScreen extends StatelessWidget {
  const CookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange[400], // 背景色をオレンジに設定
        child: const Center(child: Text('料理')),
      ),
    );
  }
}
