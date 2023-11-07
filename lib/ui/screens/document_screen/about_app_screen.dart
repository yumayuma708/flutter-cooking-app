import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('おたすけCook！について'),
      ),
      body: const Center(
        child: Text(
          'おたすけCook！についての本文',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
